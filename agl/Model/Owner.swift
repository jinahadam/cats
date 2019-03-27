//
//  Owner.swift
//  agl
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import Foundation

enum Gender: String {
    case male = "Male"
    case female = "Female"
}

struct Owner {
    let name: String
    let gender: Gender
}

