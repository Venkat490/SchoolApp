//
//  NetworkClient.swift
//  NYCSchoolApp
//
//  Created by venkat Reddy on 06/02/25.
//

import Foundation
import Combine

protocol NetworkClient {
    func fetchData(from url: URL)  ->  AnyPublisher<Data, Error>
}

class HttpClient: NetworkClient {
    
    private func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse , response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkError.badURLResponse(url: url)
        }
        return output.data
    }

    /*
     Provides publisher to fetch data for a give URL
     */
    func fetchData(from url: URL) -> AnyPublisher<Data, any Error> {
    
        return  URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap { // validate the response and if response is valid then pass the data to next operator
                guard let response = $0.response as? HTTPURLResponse,
                          response.statusCode >= 200 && response.statusCode < 300 else {
                    throw NetworkError.badURLResponse(url: url)
                }
                return $0.data
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum NetworkError: LocalizedError {
    case badURLResponse(url: URL)
    case unknown(url: URL)
    
    var errorDescription: String? {
        switch self {
            case .badURLResponse(url: let url) : return "Bad Response from URL: \(url)"
            case .unknown(url: let url) : return "Unknown error occurred from URL: \(url)"
        }
    }
}
