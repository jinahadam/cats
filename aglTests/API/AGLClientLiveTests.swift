//
//  AGLClient.swift
//  aglTests
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import XCTest
@testable import agl

class AGLClientLiveTests: XCTestCase {

    var client: AGLClient!

    override func setUp() {
        super.setUp()
        client = AGLClient(session: URLSession.shared)
    }

    func testIfCompletionBlockisMainQueue() {
        let e = expectation(description: "Testing completion block queue")
        client.fetchList { _ in
            e.fulfill()
            XCTAssertTrue(Thread.isMainThread)
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }


    func testFetchResponse() {
        let e = expectation(description: "listing response")
        client.fetchList { (result) in
            e.fulfill()
            switch result {
            case .success(let people):
                XCTAssertGreaterThan(people.count, 0)
            case .failure(let error):
                XCTFail("Error \(error)")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

