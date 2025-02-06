//
//  SchoolServiceProtocol.swift
//  NYCSchoolApp
//
//  Created by venkat Reddy on 06/02/25.
//

import Foundation
import Combine

protocol SchoolServiceProtocol {
    func fetchNYCSchools(urlString: String) -> AnyPublisher<[NYCSchool], SchoolError>
}
