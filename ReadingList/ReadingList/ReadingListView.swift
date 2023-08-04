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
                guard let index = indexSet.first else { return }
                viewModel.deleteCell(at: index)
            }
            .onMove { sourceIndexes, destination in
                viewModel.moveCells(from: sourceIndexes, to: destination)
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: ReadingListCellVM.self) { cellVM in
            Text(cellVM.book.title)
                .font(.largeTitle)
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
