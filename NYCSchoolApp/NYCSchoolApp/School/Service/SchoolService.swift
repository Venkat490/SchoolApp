//
//  SchoolService.swift
//  NYCSchoolApp
//
//  Created by venkat Reddy on 06/02/25.
//

import Foundation
import Combine
import Resolver

class SchoolService: SchoolServiceProtocol {
    @Injected var networkClient: NetworkClient

    func fetchNYCSchools(urlString: String) -> AnyPublisher<[NYCSchool], SchoolError> {
        guard let url = URL(string: urlString) else {
            return Fail(error: SchoolError.invalidURL).eraseToAnyPublisher()
        }
        return networkClient.fetchData(from: url)
            .decode(type: [NYCSchool].self, decoder: JSONDecoder())
            .mapError { $0 as? SchoolError ?? .other }
            .eraseToAnyPublisher()
    }
}

