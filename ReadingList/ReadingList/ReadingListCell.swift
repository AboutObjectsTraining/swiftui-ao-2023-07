// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct ReadingListCell: View {
    @ObservedObject var viewModel: ReadingListCellVM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(viewModel.book.title)
                .font(.headline)
            HStack(spacing: 6) {
                Text(viewModel.book.year)
                Text(viewModel.book.author.fullName)
                    .font(.subheadline)
            }
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
