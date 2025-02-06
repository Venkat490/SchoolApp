//
//  SchoolService.swift
//  NYCSchoolApp
//
//  Created by venkat Reddy on 06/02/25.
//

import Foundation
import Combine

protocol FetchSchoolDataUseCaseProtocol {
    func callAsFunction() -> AnyPublisher<[NYCSchool], SchoolError>
}
