// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import XCTest
@testable import SwiftExperiments

final class UnitTests: XCTestCase {

    func testDogInitializers() throws {
        let dog1 = Dog(name: "Rover", age: 3)
        print(dog1)
        
        let dog2 = Dog()
        print(dog2)
        
        let dog3 = Dog(age: 5)
        print(dog3)
    }
    
    func testDogEquality() throws {
        let dog1 = Dog(name: "Rover", age: 3)
        let dog2 = Dog(name: "Rover", age: 3)
        
        XCTAssert(dog1 == dog2)
    }
}


extension UnitTests {
    
    func testContactClosure() {
        let contact = Contact()
        var myPrefix = "914"
        
        let myClosure: (String, String) -> Bool = { key, value in
            value.hasPrefix(myPrefix)
        }
        
        let myPhones = contact.phones(matching: myClosure)
        print(myPhones)

        myPrefix = "516"

        let yourPhones = contact.phones { key, value in
            value.hasPrefix(myPrefix)
        }
        print(yourPhones)
    }
    
    func testGuard() {
        guard
            let y = Int("42"),
            let x = Float("\(y)")
        else { return }
        
        print(x)
    }
}
