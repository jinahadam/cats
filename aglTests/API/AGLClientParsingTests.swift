//
//  AGLClientMockTests.swift
//  aglTests
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import XCTest
@testable import agl

class AGLClientParsingTests: XCTestCase {

    var client: AGLMockClient!

    override func setUp() {
        super.setUp()
        client = AGLMockClient(session: URLSession.shared)
    }

    func testFetchResponse() {
        let e = expectation(description: "listing response")
        client.fetchList { (result) in
            e.fulfill()
            switch result {
            case .success(let people):
                XCTAssertEqual(people.count, 3)
            case .failure(let error):
                XCTFail("Error \(error)")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testPetCount() {
        let e = expectation(description: "pet count")
        client.fetchList { (result) in
            e.fulfill()
            switch result {
            case .success(let people):
                let firstPerson = people.first!
                XCTAssertEqual(firstPerson.pets!.count, 2)
            case .failure(let error):
                XCTFail("Error \(error)")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testPetDetails() {
        let e = expectation(description: "pet details")
        client.fetchList { (result) in
            e.fulfill()
            switch result {
            case .success(let people):
                let firstPerson = people.first!
                let pet1 = firstPerson.pets!.first!
                XCTAssertEqual(pet1.name, "Garfield")
                XCTAssertEqual(pet1.type, "Cat")
            case .failure(let error):
                XCTFail("Error \(error)")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

    func testForNoPets() {
        let e = expectation(description: "no pets")
        client.fetchList { (result) in
            e.fulfill()
            switch result {
            case .success(let people):
                let lastPerson = people.last!
                XCTAssertNil(lastPerson.pets)
            case .failure(let error):
                XCTFail("Error \(error)")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}

