//
//  MockGetSchoolsService.swift
//  NYCSchoolAppTests
//
//  Created by venkat Reddy on 06/02/25.
//

import Foundation
import Combine
@testable import NYCSchoolApp

class MockGetSchoolsService: SchoolServiceProtocol {
    var mockFileType: GetSchoolsMockFileType?
    
    func fetchNYCSchools(urlString: String) -> AnyPublisher<[NYCSchool], SchoolError> {
        
        return Future<[NYCSchool], SchoolError> { [weak self] promise in
            guard let mockFile = self?.mockFileType else {
                promise(.failure(.missingDependency))
                return
            }
            
            let response = UnitTestsHelper().getSchoolsResponse(mockFileType: mockFile)
            guard let schoolsResponse = response else {
                switch mockFile {
                case .failure:
                    promise(.failure(.other))
                    break
                default:
                    promise(.failure(.other))
                }
                return
            }
            promise(.success(schoolsResponse))
        }
        .eraseToAnyPublisher()
    }
}
