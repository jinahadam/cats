//
//  AGLMockCleint.swift
//  aglTests
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import Foundation
@testable import agl

class AGLMockClient: AGLClient {

    override func fetchList(completion: @escaping (Result<[Person]>) -> Void) {
        let jsonDecoder = JSONDecoder()
        let data = jsonData.data(using: .utf8)
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
