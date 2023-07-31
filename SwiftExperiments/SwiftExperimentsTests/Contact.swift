// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import Foundation

struct Contact
{
    let phones = [
        "home": "202-123-4567",
        "work": "516-456-7890",
        "mobile": "914-789-1234",
        "other:": "914-456-7890"
    ]
    
    func phones(matching: (String, String) -> Bool) -> [String: String] {
        var matchedPhones = [String: String]()
        
        for (key, value) in phones {
            if matching(key, value) {
                matchedPhones[key] = value
            }
        }

        return matchedPhones
    }
}
