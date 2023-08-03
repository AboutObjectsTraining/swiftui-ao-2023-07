// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

@main
struct CoolnessApp: App {
    
    @StateObject private var coolViewModel = CoolViewModel.testModel
    
    var body: some Scene {
        WindowGroup {
            CoolView()
                .environmentObject(coolViewModel)
        }
    }
}
