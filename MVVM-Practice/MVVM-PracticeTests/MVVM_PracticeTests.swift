//
//  MVVM_PracticeTests.swift
//  MVVM-PracticeTests
//
//  Created by Khurram Iqbal on 01/12/2021.
//

import XCTest
@testable import MVVM_Practice

class MVVM_PracticeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let repo = MockMovieListRepository.init(networkManager: NetworkManager.sharedInstance)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
