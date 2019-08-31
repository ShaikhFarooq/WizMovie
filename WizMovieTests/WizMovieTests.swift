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
        let movieTitle = "batman"
        guard let movTitle =         movieTitle.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)else{
            return
        }
        let url: String = "\(EndPoints.Search.path)\(movTitle)\(APIKey.ApiKey.rawValue)"
        networkService.searchMoviesOnJson(urlByName: url,type: Movies.self) { (response,success,error) in
            XCTAssertNil(error)
            XCTAssertTrue(success == "True")
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSearchNoMovieAvailable() {
        let promise = expectation(description: "Search for ba movies")
        let movieTitle = "ba"
        guard let movTitle =         movieTitle.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)else{
            return
        }
        let url: String = "\(EndPoints.Search.path)\(movTitle)\(APIKey.ApiKey.rawValue)"
        networkService.searchMoviesOnJson(urlByName: url,type: Movies.self) { (response,success,error) in
            XCTAssertTrue(success == "False")
            XCTAssertEqual("The operation couldn’t be completed. (No Movie error -101.)",
                           error?.localizedDescription)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testMovieWithTitle(){
        let promise = expectation(description: "Search for City of God movies")
        let movieTitle = "City of God"
        guard let movTitle =         movieTitle.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)else{
            return
        }
        let url: String = "\(EndPoints.Title.path)\(movTitle)\(APIKey.ApiKey.rawValue)"
        print(url)
        networkService.searchMoviesOnJson(urlByName: url,type: MovieDetails.self) { (response,success,error) in
            XCTAssertNil(error)
            XCTAssertTrue(success == "True")
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testMovieWithTitleNotAvailable() {
        let promise = expectation(description: "Search for ba movies")
        let movieTitle = "raju cha"
        guard let movTitle =         movieTitle.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)else{
            return
        }
        let url: String = "\(EndPoints.Title.path)\(movTitle)\(APIKey.ApiKey.rawValue)"
        print(url)
        networkService.searchMoviesOnJson(urlByName: url,type: MovieDetails.self) { (response,success,error) in
            XCTAssertTrue(success == "False")
            XCTAssertEqual("The operation couldn’t be completed. (No Movie error -101.)",
                           error?.localizedDescription)
            promise.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    
    func testNetworkConnectionWhenOffline(){
        XCTAssertFalse(NetworkConnection.isConnectedToNetwork())
    }
    
    func testNetworkConnectionWhenOnline(){
        XCTAssertTrue(NetworkConnection.isConnectedToNetwork())
    }
    
    func testCheckNoFavoriteMoviesMessge(){
        XCTAssertEqual("No Favorite Movies Found",noFavMovies)
    }
    
    func testCheckNoNetworkMessge(){
        XCTAssertEqual("Network Error”, “Unable to contact the server.",networkError)
    }
    
    func testCheckLoadingMessage(){
        XCTAssertEqual("Please wait....",loadingMessage)
    }
    
    func testCheckSearchMessge(){
        XCTAssertEqual("Search your favorite movies.",searchMessage)
    }
    
    func testCheckNoMovieMessge(){
        let movieName = "ba"
        XCTAssertEqual("No Movies Found for ba","\(noMovieFound )\(movieName)")
    }
    
}
