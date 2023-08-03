// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation

struct Author: Codable, Identifiable, Hashable, CustomStringConvertible {
    var id = UUID()
    var firstName: String
    var lastName: String
    
    static let unknown = "unknown"
    
    var fullName: String {
        switch (firstName, lastName) {
            case ("", ""): return Author.unknown
            case (let name, ""), ("", let name): return name
            default: return "\(firstName) \(lastName)"
        }
    }
    
    var description: String { fullName }
    
    init(firstName: String? = nil, lastName: String? = nil) {
        self.firstName = firstName ?? ""
        self.lastName = lastName ?? ""
    }
}
