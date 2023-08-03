// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

final class ReadingListVM: ObservableObject {
    
    private let store: DataStore
    @Published private(set) var cellViewModels: [ReadingListCellVM] = []
    @Published private(set) var readingList: ReadingList {
        didSet {
            cellViewModels = readingList.books.map { ReadingListCellVM(book: $0) }
        }
    }
    
    
    init(store: DataStore = DataStore()) {
        self.store = store
        readingList = ReadingList(title: "Empty", books: [])
    }
}


// MARK: Intents

extension ReadingListVM {
    
    func loadIfEmpty() {
        guard readingList.books.isEmpty else { return }
        
        Task {
            do {
                readingList = try await store.fetchWithAsyncAwait()
            } catch {
                print("Unable to fetch ReadingList from \(store)")
            }
        }
    }
}
