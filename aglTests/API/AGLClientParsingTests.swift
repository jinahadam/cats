//
//  AGLClientMockTests.swift
//  aglTests
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import XCTest
@testable import agl

class AGLMockClient: AGLClient {

    override func fetchList(completion: @escaping (Result<[Person]>) -> Void) {
        let jsonDecoder = JSONDecoder()
        let data = jsonData.data(using: .utf16)
        do {
            let peopleList = try jsonDecoder.decode([Person].self, from: data!)
            DispatchQueue.main.async {
                completion(Result.success(peopleList))
            }
        } catch let e {
            print(e)
            let bodyString = String(data: data!, encoding: .utf8)
            DispatchQueue.main.async {
                completion(Result.failure(APIError.invalidJSON(bodyString ?? "invalid JSON")))
            }
        }
        
    }
}

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
                XCTAssertEqual(people.count, 2)
            case .failure(let error):
                XCTFail("Error \(error)")
            }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

