//
//  Cat.swift
//  agl
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import Foundation

struct Cat {
    static let type = "Cat"

    let name: String
    let owner: Owner
}

extension Cat: Comparable {
    static func == (lhs: Cat, rhs: Cat) -> Bool {
        return lhs.name == rhs.name
    }

    static func < (lhs: Cat, rhs: Cat) -> Bool {
        return lhs.name < rhs.name
    }

}
