//
//  MockFetchSchoolDataUseCase.swift
//  NYCSchoolAppTests
//
//  Created by venkat Reddy on 06/02/25.
//

import Foundation
import Combine
@testable import NYCSchoolApp

class MockFetchSchoolDataUseCase: FetchSchoolDataUseCaseProtocol {
    
    var result: Result<[NYCSchool], SchoolError>!
    
    func callAsFunction() -> AnyPublisher<[NYCSchool], SchoolError> {
        return Future { promise in
            promise(self.result)
        }
        .eraseToAnyPublisher()
    }
}
