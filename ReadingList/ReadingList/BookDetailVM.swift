// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

final class BookDetailVM: ObservableObject {
    
    @Published var book: Book
    
    init(book: Book) {
        self.book = book
    }
}
