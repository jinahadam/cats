//
//  CatDataTests.swift
//  aglTests
//
//  Created by Jinah Adam on 27/3/19.
//  Copyright © 2019 Jinah Adam. All rights reserved.
//

import XCTest
@testable import agl

class CatDataTests: XCTestCase {
    let pet1 = Pet(name: "Garfield", type: "Cat")
    let pet2 = Pet(name: "Fido", type: "Dog")
    lazy var person1 = Person(name: "Bob", age: 23, gender: "Male", pets: [pet1, pet2])
    lazy var person2 = Person(name: "Jennifer", age: 23, gender: "Female", pets: [pet1])
    var catData: CatData!

    override func setUp() {
        super.setUp()
        catData = CatData(responseModel: [person1, person2])
    }

    func testCatDataInit() {
        XCTAssertEqual(catData.cats.count, 2)
    }

    func testCatsWithFemaleOwnersCount() {
        XCTAssertEqual(catData.catsWithFemaleOwners.count, 1)
        XCTAssertEqual(catData.catsWithFemaleOwners.first!.name, pet1.name)
        XCTAssertEqual(catData.catsWithFemaleOwners.first!.owner.name, person2.name)
    }

    func testCatsWithMaleOwnersCount() {
        XCTAssertEqual(catData.catsWithMaleOwners.count, 1)
        XCTAssertEqual(catData.catsWithMaleOwners.first!.name, pet1.name)
        XCTAssertEqual(catData.catsWithMaleOwners.first!.owner.name, person1.name)
    }

    func testShouldReturnOnlyCats() {

    }

}
