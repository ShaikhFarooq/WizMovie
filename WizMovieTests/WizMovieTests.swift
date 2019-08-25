//
//  WizMovieTests.swift
//  WizMovieTests
//
//  Created by Admin on 8/24/19.
//  Copyright © 2019 Farooq. All rights reserved.
//

import XCTest
@testable import WizMovie

class WizMovieTests: XCTestCase {

    private let networkService = Network.shared

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testSearchWithMovieAvailable() {
        let promise = expectation(description: "Search for batman movies")
        let url: String = "\(EndPoints.Search.path)\("batman")\(APIKey.ApiKey.rawValue)"
        networkService.searchMoviesOnJson(urlByName: url,type: Movies.self) { (response,success,error) in
            XCTAssertNil(error)
            XCTAssertTrue(success == "True")
            promise.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testSearchNoMovieAvailable() {
        let promise = expectation(description: "Search for ba movies")
        let url: String = "\(EndPoints.Search.path)\("ba")\(APIKey.ApiKey.rawValue)"
        networkService.searchMoviesOnJson(urlByName: url,type: Movies.self) { (response,success,error) in
            XCTAssertTrue(success == "False")
            XCTAssertEqual("The operation couldn’t be completed. (No Movie error -101.)",
                           error?.localizedDescription)
            promise.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
