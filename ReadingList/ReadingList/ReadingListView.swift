// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct ReadingListView: View {
    
    @EnvironmentObject var viewModel: ReadingListVM
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.cellViewModels, id: \.book) { cellVM in
                    NavigationLink(value: cellVM) {
                        
                        ReadingListCell(viewModel: cellVM)
                    }
                }
            }
            .navigationTitle(viewModel.readingList.title)
            .navigationDestination(for: ReadingListCellVM.self) { cellVM in
                Text(cellVM.book.title)
                    .font(.largeTitle)
            }
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
    }
}
#endif
