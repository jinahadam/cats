//
//  Person.swift
//  agl
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import Foundation


struct Person: Codable {
    let name: String
    let age: Int
    let gender: String
    let pets: [Pet]
}

