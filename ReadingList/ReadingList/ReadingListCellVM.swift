// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

final class ReadingListCellVM: ObservableObject {
    @Published var book: Book
    
    init(book: Book) {
        self.book = book
    }
    
    func makeBookDetailVM() -> BookDetailVM {
        BookDetailVM(book: book)
    }
}

extension ReadingListCellVM: Hashable {
    
    static func == (lhs: ReadingListCellVM, rhs: ReadingListCellVM) -> Bool {
        lhs.book.id == rhs.book.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(book)
    }
}
