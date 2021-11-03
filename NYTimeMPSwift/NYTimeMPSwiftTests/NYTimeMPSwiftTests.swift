//
//  NYTimeMPSwiftTests.swift
//  NYTimeMPSwiftTests
//
//  Created by Atif on 03/11/2021.
//  Copyright © 2021 Atif. All rights reserved.
//

import XCTest
@testable import NYTimeMPSwift

class NYTimeMPSwiftTests: XCTestCase {
    var mpNewsApi = MPNewsAPI()
    
    func testApiResponse() throws {
        try XCTSkipUnless(Reachability.isConnectedToNetwork(), "~~ Internet Disconnected ~~")
        
        // ~~ Test data ~~
        let page = 0
        let period = 7
        var status: String?
        let exptedStatus = "ok"
        var responseError: Error?
        let expectation = expectation(description: exptedStatus)
        
        mpNewsApi.getNews(page: page, period: period) { (response) in
            switch response {
                case .success(let result):
                    debugPrint("Unit test completed")
                    status = result.status.lowercased()
                case.failure:
                    let error = NSError(domain: "Failed", code: 500, userInfo: [NSLocalizedDescriptionKey: "Invalid request"])
                    responseError = error
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNil(responseError)
        XCTAssertEqual(status, exptedStatus)
    }
}
