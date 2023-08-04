// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct AddBookView: View {

    let addBook: (Book) -> Void
    let cancelAddBook: () -> Void
    
    @State var book = Book()
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Book") {
                    TextField("Title", text: $book.title)
                    TextField("Year", text: $book.year)
                }
                Section("Author") {
                    TextField("First Name", text: $book.author.firstName)
                    TextField("Last Name", text: $book.author.lastName)
                }
            }
            .navigationTitle("Add Book")
            .interactiveDismissDisabled()
            .toolbar {
                Button("Cancel", action: cancelAddBook)
                Button("Done", action: { addBook(book) })
            }
        }
    }
}

#if DEBUG
struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView(addBook: { book in }, cancelAddBook: { })
        ReadingListView()
            .environmentObject(ReadingListVM())
    }
}
#endif
