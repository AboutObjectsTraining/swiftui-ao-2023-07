// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct ReadingListCell: View {
    @ObservedObject var viewModel: ReadingListCellVM
    
    var body: some View {
        HStack() {
            ThumbnailView(viewModel: viewModel)
            VStack(alignment: .leading, spacing: 6) {
                Text(viewModel.book.title)
                    .font(.headline)
                HStack(spacing: 6) {
                    Text(viewModel.book.year)
                    Text(viewModel.book.author.fullName)
                        .font(.subheadline)
                }
            }
            
            Spacer()
            
            ProgressView(value: viewModel.book.percentComplete)
                .progressViewStyle(CompletionProgressViewStyle())
        }
    }
}

struct ThumbnailView: View {
    @ObservedObject var viewModel: ReadingListCellVM
    
    var body: some View {
        
        AsyncImage(url: viewModel.book.artworkUrl) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
            } else if phase.error == nil {
                ProgressView()
            } else {
                ThumbnailPlaceholder(viewModel: viewModel)
            }
        }
    }
}

struct ThumbnailPlaceholder: View {
    @ObservedObject var viewModel: ReadingListCellVM
    
    var body: some View {
        ZStack() {
            Rectangle()
                .fill(.red)
                .frame(width: 40, height: 60)
            Image(systemName:"photo.fill")
                .foregroundColor(.white)
                .imageScale(.large)
        }
    }
}


#if DEBUG
struct ReadingListCell_Previews: PreviewProvider {
    
    static var previews: some View {
        ReadingListCell(viewModel: TestData.cellVM)
            .border(.blue)
            .previewLayout(.sizeThatFits)
        ReadingListView()
            .environmentObject(ReadingListVM())
    }
}
#endif
