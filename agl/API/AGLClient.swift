//
//  AglClient.swift
//  agl
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import Foundation

enum Result<T: Decodable> {
    case success(T)
    case failure(APIError)
}

enum APIError: Error {
    case connectionError(Error)
    case notFound //40x
    case serverError //50x
    case invalidJSON(String)
}

class AGLClient {
    let session: URLSession

    init(session: URLSession) {
        self.session = session
    }

    func fetchList(completion: @escaping (Result<[Person]>) -> Void) {
        let url = URL(string: "http://agl-developer-test.azurewebsites.net/people.json")!
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) in
            if let e = error {
                DispatchQueue.main.async {
                    completion(Result.failure(APIError.connectionError(e)))
                }
            } else {
                let http = response as! HTTPURLResponse
                switch http.statusCode {
                case 200:
                    let jsonDecoder = JSONDecoder()
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

                default:
                    DispatchQueue.main.async {
                        completion(Result.failure(APIError.serverError))
                    }
                }
            }
        }
        task.resume()
    }
}
