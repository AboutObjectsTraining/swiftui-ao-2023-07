// Copyright (C) 2022 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI


struct BookView: View {
    var update: (Book) -> Void
    @ObservedObject var viewModel: BookVM
    @State private var hasChanges = false
    
    var body: some View {
        Form {
            BookSection(viewModel: viewModel)
            AuthorSection(viewModel: viewModel)
            ProgressSection(viewModel: viewModel)
            ImageSection(viewModel: viewModel)
                .listRowBackground(Color.clear)
        }
        .navigationTitle("Book Detail")
        .navigationBarBackButtonHidden(viewModel.isEditing)
        .toolbar {
            Button(action: toggleEditing) {
                Text(viewModel.isEditing ? "Done" : "Edit")
                    .fontWeight(viewModel.isEditing ? .semibold : .regular)
            }
        }
        .onDisappear {
            if hasChanges {
                update(viewModel.book)
            }
        }
    }
    
    func toggleEditing() {
        if viewModel.isEditing {
            hasChanges = true
            // FIXME: Cell's ProgressView sets `fractionCompleted` to nil
            // This problem surfaces in the ReadingListCell's progress view.
            // For now, we invoke `updateHandler(_:)` redundantly as a workaround.
            update(viewModel.book)
        }

        viewModel.isEditing.toggle()
    }
}

struct BookSection: View {
    @ObservedObject var viewModel: BookVM
    @FocusState var isFocused: Bool
    
    var body: some View {
        Section(
            content: {
                TitledCell(title: "Title", value: $viewModel.book.title, isEditing: $viewModel.isEditing)
                    .focused($isFocused)
                    .onChange(of: viewModel.isEditing) { isEditing in
                        isFocused = isEditing
                    }
                TitledCell(title: "Year", value: $viewModel.book.year, isEditing: $viewModel.isEditing)
                    .keyboardType(.numberPad)
            },
            header: {
                Label("Book", systemImage: "book")
            }
        )
    }
}

struct AuthorSection: View {
    @ObservedObject var viewModel: BookVM
    
    var body: some View {
        Section(
            content: {
                TitledCell(title: "First Name",
                           value: ($viewModel.book.author.firstName),
                           isEditing: $viewModel.isEditing)
                TitledCell(title: "Last Name",
                           value: ($viewModel.book.author.lastName),
                           isEditing: $viewModel.isEditing)
            },
            header: {
                Label("Author", systemImage: "person")
            }
        )
    }
}

struct ProgressSection: View {
    @ObservedObject var viewModel: BookVM
    
    var body: some View {
        Section (
            content: {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Percent Complete")
                        .font(.caption)
                        .foregroundColor(.brown)
                    
                    Text(viewModel.book.percentComplete, format: .percent)
                    
                    if viewModel.isEditing {
                        Slider(
                            value: $viewModel.book.percentComplete,
                            in: 0.0...1.0,
                            step: 0.1,
                            label: { Text("Percent Complete") }
                        )
                    }
                }
                .animation(.linear(duration: 0.15), value: viewModel.isEditing)
            },
            header: {
                Label("Progress", systemImage: "chart.line.flattrend.xyaxis")
            }
        )
    }
}

struct ImageSection: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewModel: BookVM
        
    var body: some View {
        HStack {
            Spacer()
            AsyncImage(url: viewModel.book.artworkUrl) { image in
                
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(viewModel.isEditing ? 0.5 : 1.0)
                    .shadow(color: hasShadow() ? .secondary : .clear,
                            radius: 5, x: 2, y: 2)
                    .overlay {
                        Rectangle()
                            .strokeBorder(lineWidth: viewModel.isEditing ? 6 : 0)
                            .foregroundColor(.blue)
                            .opacity(viewModel.isEditing ? 1 : 0.5)
                            .padding(viewModel.isEditing ? -6 : 0)
                            .animation(.easeInOut.speed(0.25).repeatForever(autoreverses: true),
                                       value: viewModel.animateBorder)
                    }
            } placeholder: {
                MissingImage()
            }
            Spacer()
        }
        .frame(height: 180)
    }
    
    private func hasShadow() -> Bool {
        return colorScheme == .light && !viewModel.isEditing
    }
}

struct MissingImage: View {
    var body: some View {
        Image(systemName: "photo")
            .imageScale(.large)
            .font(.system(size: 30))
            .foregroundColor(.secondary)
            .overlay {
                Rectangle()
                    .stroke(.secondary, lineWidth: 1)
                    .frame(width: 120, height: 160)
            }
    }
}


#if DEBUG
struct BookView_Previews: PreviewProvider {
    static let bookVM = BookVM(book: TestData.book)
    static let bookVMWithNoCoverImage = BookVM(book: TestData.bookWithNoCoverImage)
    static var previews: some View {
        NavigationStack {
            BookView(update: { _ in }, viewModel: bookVM)
        }
        .previewDisplayName("Book View")
        NavigationStack {
            BookView(update: { _ in }, viewModel: bookVM)
        }
        .previewDisplayName("Book View Dark")
        .preferredColorScheme(.dark)
        NavigationStack {
            BookView(update: { _ in }, viewModel: bookVMWithNoCoverImage)
        }
        .previewDisplayName("Book w/o Cover")
        NavigationStack {
            BookView(update: { _ in }, viewModel: bookVMWithNoCoverImage)
        }
        .previewDisplayName("Book w/o Cover Dark")
        .preferredColorScheme(.dark)
    }
}
#endif

