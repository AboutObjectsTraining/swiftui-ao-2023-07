// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct TestData {
    
    static var author: Author {
        Author(firstName: "William", lastName: "Shakespeare")
    }
    
    static var book: Book {
        Book(title: "The Tempest", year: "1999", author: author, percentComplete: 0)
    }
    
    static var cellVM: ReadingListCellVM {
        ReadingListCellVM(book: book)
    }
}
