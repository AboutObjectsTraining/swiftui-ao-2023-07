// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 20.0) {
            Text("Hello!")
            Button("Press Me") {
                
            }
            Image(systemName: "person.fill")
                .foregroundColor(.purple)
            Image(systemName: "globe")
                .foregroundColor(.green)
            Text("Hello, Class!")
                .foregroundColor(.indigo)
        }
        .font(.largeTitle)
        .imageScale(.large)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.brown.opacity(0.2))
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
        ContentView()
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark Mode")
    }
}
