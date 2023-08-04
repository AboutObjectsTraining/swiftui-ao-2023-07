// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct OriginalBookDetailView: View {
    
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
            Button(viewModel.isEditing ? "Done" : "Edit", action: { })
        }
    }
}


#if DEBUG

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            OriginalBookDetailView(viewModel: BookDetailVM(book: TestData.book),
                           updateBook: { book in },
                           cancelAddBook: { })
        }
        .navigationTitle("Book Detail")
    }
}
#endif
