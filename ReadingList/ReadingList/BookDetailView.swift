// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct BookDetailView: View {
    
    @ObservedObject var viewModel: BookDetailVM
    
    let updateBook: (Book) -> Void
    let cancelAddBook: () -> Void

    
    var body: some View {
        Form {
            Section("Book") {
                TextField("Title", text: $viewModel.book.title)
                TextField("Year", text: $viewModel.book.year)
            }
            Section("Author") {
                TextField("First Name", text: $viewModel.book.author.firstName)
                TextField("Last Name", text: $viewModel.book.author.lastName)
            }
        }
        .navigationTitle("Book Detail")
        .toolbar {
            Button("Cancel", action: cancelAddBook)
            Button("Done", action: { updateBook(viewModel.book) })
        }
    }
}
