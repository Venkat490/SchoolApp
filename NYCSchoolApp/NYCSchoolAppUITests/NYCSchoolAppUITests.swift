//
//  NYCSchoolAppUITests.swift
//  NYCSchoolAppUITests
//
//  Created by venkat Reddy on 06/02/25.
//

import XCTest

final class NYCSchoolAppUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchArguments.append("UITest")
    }

    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testLoadingIndicatorShowsOnLaunch() {
        app.launchArguments.append("MOCK_VIEWMODEL_DATA_LOADING")
        app.launch()
        
        let loadingIndicator = app.activityIndicators["LoadingIndicator"]
        XCTAssertTrue(loadingIndicator.exists)
    }
    
    func testSchoolListDisplaysSchools() {
        app.launchArguments.append("MOCK_VIEWMODEL_DATA_LOADED")
        app.launch()
        
        let schoolsList = app.tables["SchoolsList"]
        XCTAssertTrue(schoolsList.waitForExistence(timeout: 5))
        
        let firstSchoolCell = schoolsList.cells.element(boundBy: 0)
        XCTAssertTrue(firstSchoolCell.exists)
        
        XCTAssertTrue(firstSchoolCell.staticTexts["Test School"].exists)
        XCTAssertTrue(firstSchoolCell.staticTexts["Test City"].exists)
    }
    
    func testErrorAlertShownOnFailure() {
        app.launchArguments.append("MOCK_VIEWMODEL_DATA_LOADING_FAILURE")
        app.launch()
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 5))
        XCTAssertTrue(alert.staticTexts["Test error message"].exists)
    }

    func testNavigationToDetailScreen() {
        app.launchArguments.append("MOCK_VIEWMODEL_DATA_LOADED")
        app.launch()
        
        let schoolsList = app.tables["SchoolsList"]
        XCTAssertTrue(schoolsList.waitForExistence(timeout: 5))
        
        schoolsList.cells.element(boundBy: 0).tap()
        
        let detailDescription = app.staticTexts["DetailDescription"]
        XCTAssertTrue(detailDescription.waitForExistence(timeout: 1))
    }
}
