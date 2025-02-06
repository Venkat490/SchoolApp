//
//  App+Injection.swift
//  NYCSchoolApp
//
//  Created by venkat Reddy on 06/02/25.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        registerSchoolDependencies()
    }

    static func registerSchoolDependencies() {
        register { SchoolService() }
            .implements(SchoolServiceProtocol.self)
        
        register { FetchSchoolDataUseCase() }
            .implements(FetchSchoolDataUseCaseProtocol.self)
        
        register { HttpClient() }
            .implements(NetworkClient.self)
    }
}
