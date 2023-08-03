// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct CoolView: View {
    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            
            VStack(spacing: 1) {
                AccessoryView()
                ContentView()
            }
        }
    }
}

#if DEBUG
struct CoolView_Previews: PreviewProvider {
    static var previews: some View {
        CoolView()
            .environmentObject(CoolViewModel.testModel)
    }
}
#endif
