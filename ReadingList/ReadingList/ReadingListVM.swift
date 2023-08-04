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
    
    @Published var isAddingBook = false
    
    
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
    
    func moveCells(from sourceIndexes: IndexSet, to index: Int) {
        cellViewModels.move(fromOffsets: sourceIndexes, toOffset: index)
        save()
    }
    
    func addBook() {
        isAddingBook = true
    }
    
    func add(book: Book) {
        let cellVM = ReadingListCellVM(book: book)
        cellViewModels.insert(cellVM, at: 0)
        isAddingBook = false
        save()
    }
    
    func update(book: Book) {
        guard let cellVM = cellViewModels.first(where: { $0.book.id == book.id }) else {
            fatalError("\(#function) - Unable to find book \(book)")
        }
        cellVM.book = book
        save()
    }
    
    func cancel() {
        isAddingBook = false
    }
    
    // TODO: Implement me!
    private func save() {
        readingList.books = cellViewModels.map { $0.book }
        
        do {
            try store.save(readingList: readingList)
        }
        catch {
            print("Couldn't save reading list to store \(store) due to \(error)")
        }
    }
    
    @MainActor func loadIfEmpty() {
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
