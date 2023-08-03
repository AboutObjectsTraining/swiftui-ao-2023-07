// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

@main
struct ReadingListApp: App {
    
    @StateObject private var readingListViewModel = ReadingListVM()
    
    var body: some Scene {
        WindowGroup {
            ReadingListView()
                .environmentObject(readingListViewModel)
        }
    }
}
