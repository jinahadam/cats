//
//  CatData.swift
//  agl
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import Foundation

struct CatData {
    var cats: [Cat]

    var catsWithFemaleOwners: [Cat] {
        return cats.filter { $0.owner.gender == .female }.sorted()
    }

    var catsWithMaleOwners: [Cat] {
        return cats.filter { $0.owner.gender == .male }.sorted()
    }

    init(responseModel: [Person]) {
        self.cats = [Cat]()
        for person in responseModel {
            guard let gender = Gender(rawValue: person.gender),
                  let pets = person.pets  else { continue }

            let petCats = pets.filter { $0.type == Cat.type }
            let owner = Owner(name: person.name,
                             gender: gender)

            self.cats.append(contentsOf: petCats.map { Cat(name: $0.name, owner: owner) })
        }

    }

}
