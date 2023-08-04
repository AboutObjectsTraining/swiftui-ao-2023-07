// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct ReadingListView: View {
    
    @EnvironmentObject var viewModel: ReadingListVM
    
    var listOfBooks: some View {
        List {
            ForEach(viewModel.cellViewModels, id: \.book) { cellVM in
                NavigationLink(value: cellVM) {
                    ReadingListCell(viewModel: cellVM)
                }
                .listRowBackground(Color.brown.opacity(0.1))
            }
            .onDelete { indexSet in
                deleteCells(at: indexSet)
            }
            .onMove { sourceIndexes, destination in
                moveCells(at: sourceIndexes, to: destination)
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: ReadingListCellVM.self) { cellVM in
            BookDetailView(viewModel: cellVM.makeBookDetailVM(),
                           updateBook: viewModel.update(book:),
                           cancelAddBook: viewModel.cancel)
        }
    }
    
    var empty: some View {
        ZStack {
            Rectangle()
                .fill(.brown.opacity(0.1))
                .ignoresSafeArea()
            Text("This reading list is currently empty. Tap the Add button to add a book")
                .padding(40)
                .multilineTextAlignment(.center)
                .lineSpacing(6)
                .font(.title3)
                .italic()
                .foregroundColor(.secondary)
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if (viewModel.cellViewModels.isEmpty) {
                    empty
                } else {
                    listOfBooks
                }
            }
            .navigationTitle(viewModel.readingList.title)
            .toolbar {
                // TODO: Implement add button actions
                ToolbarItem(placement: .navigation) {
                    Button(action: addBook, label: { Image(systemName: "plus.circle.fill") })
                }
                ToolbarItem(placement: .primaryAction) {
                    EditButton()
                }
            }
            .tint(.brown)
        }
        .onAppear {
            viewModel.loadIfEmpty()
        }
        .sheet(isPresented: $viewModel.isAddingBook) {
            AddBookView(
                addBook: viewModel.add(book:),
                cancel: viewModel.cancel
            )
        }
    }
}

// MARK: Intents
extension ReadingListView {

    private func deleteCells(at indexes: IndexSet) {
        // TODO: Move guard to VM.
        guard let index = indexes.first else { return }
        viewModel.deleteCell(at: index)
    }
    
    private func moveCells(at sourceIndexes: IndexSet, to destination: Int) {
        viewModel.moveCells(from: sourceIndexes, to: destination)
    }
    
    private func addBook() {
        viewModel.addBook()
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var viewModel: ReadingListVM = {
        var vm = ReadingListVM()
        vm.loadIfEmpty()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            vm.cellViewModels[0].book.percentComplete = 1.0
            vm.cellViewModels[1].book.percentComplete = 0.9
            vm.cellViewModels[2].book.percentComplete = 0.6
            vm.cellViewModels[3].book.percentComplete = 0.3
        }
        return vm
    }()
    
    static var previews: some View {
        ReadingListView()
            .environmentObject(viewModel)
        ReadingListView()
            .environmentObject(viewModel)
            .preferredColorScheme(.dark)
            .previewDisplayName("Reading List Dark")
        ReadingListView()
            .environmentObject(ReadingListVM(store: DataStore(storeName: "EmptyList")))
    }
}
#endif
