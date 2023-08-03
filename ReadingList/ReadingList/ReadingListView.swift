// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct ReadingListView: View {
    
    @EnvironmentObject var viewModel: ReadingListVM
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.readingList.books) { book in
                    NavigationLink(value: book) {
                        Text(book.title)
                    }
                }
            }
            .navigationTitle(viewModel.readingList.title)
            .navigationDestination(for: Book.self) { book in
                Text(book.title)
                    .font(.largeTitle)
            }
        }
        .onAppear {
            viewModel.loadIfEmpty()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ReadingListView()
            .environmentObject(ReadingListVM())
    }
}
