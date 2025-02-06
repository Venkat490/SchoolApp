//
//  NYCSchoolAppTests.swift
//  NYCSchoolAppTests
//
//  Created by venkat Reddy on 06/02/25.
//

import XCTest
import Combine
import Resolver
@testable import NYCSchoolApp


final class NYCSchoolAppTests: XCTestCase {

    @LazyInjected private var service: SchoolServiceProtocol
    private var subscriptions: Set<AnyCancellable> = []

    var mockService: MockGetSchoolsService? {
        service as? MockGetSchoolsService
    }
    
    override func setUpWithError() throws {
        Resolver.defaultScope = .shared
        Resolver.register{ UnitTestsHelper() }
        Resolver.register { MockGetSchoolsService() }
            .implements(SchoolServiceProtocol.self)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_fetch_schools_success() throws {
        mockService?.mockFileType = .succes
        let viewModel = NYCSchoolViewModel()
        XCTAssertEqual(viewModel.schools.count, 0)
                
        let expectation = expectation(description: "schools loaded")
        viewModel.$schools
            .dropFirst()
            .sink { schools in
                expectation.fulfill()
            }.store(in: &subscriptions)
        waitForExpectations(timeout: 10)
        
        XCTAssertTrue(viewModel.schools.count > 0)
        XCTAssertEqual(viewModel.schools.count, 3)
    }
    
    func test_fetch_schools_failure() throws {
        mockService?.mockFileType = .failure
        let viewModel = NYCSchoolViewModel()
        XCTAssertEqual(viewModel.schools.count, 0)
                
        let expectation = expectation(description: "schools loaded")
        viewModel.$schools
            .dropFirst()
            .sink { schools in
                expectation.fulfill()
            }.store(in: &subscriptions)
        waitForExpectations(timeout: 10)
        
        XCTAssertTrue(viewModel.schools.count == 0)
        XCTAssertEqual(viewModel.schools.count, 0)
    }

    func test_isLoading_State_on_fetch() {
        mockService?.mockFileType = .succes
        let viewModel = NYCSchoolViewModel()
        XCTAssertTrue(viewModel.isLoading)
        
        let expectation = expectation(description: "schools loaded")
        viewModel.$schools
            .dropFirst()
            .sink { schools in
                expectation.fulfill()
            }.store(in: &subscriptions)
        waitForExpectations(timeout: 10)
        XCTAssertFalse(viewModel.isLoading)
    }
}
