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
                // TODO: Implement me!
            }
            .onMove { from, to in
                // TODO: Implement me!
            }
        }
    }
    
    var empty: some View {
        Text("This reading list is currently empty. Tap the Add button to add a book")
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
            .listStyle(.plain)
            .navigationTitle(viewModel.readingList.title)
            .navigationDestination(for: ReadingListCellVM.self) { cellVM in
                Text(cellVM.book.title)
                    .font(.largeTitle)
            }
            .toolbar {
                // TODO: Implement add and edit button actions
                ToolbarItem(placement: .navigation) {
                    Button(action: { }, label: { Image(systemName: "plus.circle.fill") })
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
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingListView()
            .environmentObject(ReadingListVM())
        ReadingListView()
            .environmentObject(ReadingListVM(store: DataStore(storeName: "EmptyList")))
    }
}
#endif
