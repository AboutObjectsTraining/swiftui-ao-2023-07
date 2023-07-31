// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation

struct Dog {
    var name: String
    var age: Int
    let pointsPerPixel: Int
    
    init(name: String = "Unknown", age: Int = 0, pointsPerPixel: Int = 2) {
        self.name = name
        self.age = age
        self.pointsPerPixel = pointsPerPixel
    }
}


extension Dog: Equatable {
    
    static func ==(left: Self, right: Self) -> Bool {
        left.name == right.name
    }
}




extension Int {
    var foo: Int { 3 }
}
