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
        readingList = ReadingList(title: "Untitled", books: [])
    }
}


// MARK: Intents

extension ReadingListVM {
    
    func deleteCell(at index: Int) {
        cellViewModels.remove(at: index)
        save()
    }
    
    // TODO: Implement me!
    private func save() {
        // let books = cellViewModels.map { $0.book }
        // Call save on the data store
    }
    
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
