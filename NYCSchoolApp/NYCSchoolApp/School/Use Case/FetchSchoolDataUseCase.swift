//
//  FetchSchoolDataUseCase.swift
//  NYCSchoolApp
//
//  Created by venkat Reddy on 06/02/25.
//

import Foundation
import Combine
import Resolver

class FetchSchoolDataUseCase: FetchSchoolDataUseCaseProtocol {
    
    @Injected private var schoolService: SchoolServiceProtocol
    
    func callAsFunction() -> AnyPublisher<[NYCSchool], SchoolError> {
        return schoolService.fetchNYCSchools(urlString: ServiceURLs.getSchoolsURL)
    }
}
