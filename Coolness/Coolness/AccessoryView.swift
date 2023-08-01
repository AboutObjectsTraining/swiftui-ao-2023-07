// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct AccessoryView: View {
    // TODO: Migrate to view model
    @State private var text = ""
    
    var body: some View {
        HStack {
            textField
            addButton
        }
        .padding()
        .frame(maxWidth: .infinity)
        .frame(height: 80)
        .background(.thickMaterial)
    }
}

// MARK: Intents (Actions)
extension AccessoryView {
    
    private func addCell() {
        // TODO: Implement me!
    }
    
    private func clear() {
        text = ""
    }
}

// MARK: View Configuration
extension AccessoryView {
    
    private var addButton: some View {
        Button(action: addCell, label: addButtonImage)
    }
    
    private var textField: some View {
        ZStack(alignment: .trailing) {
            TextField("Type here...", text: $text)
                .textFieldStyle(.roundedBorder)
            
            if !text.isEmpty {
                Button(action: clear, label: clearButtonImage)
                    .padding(.trailing, 6)
            }
        }
    }
    
    private func addButtonImage() -> some View {
        Image(systemName: "plus.circle.fill")
            .imageScale(.large)
            .font(.system(size: 22))
            .tint(.orange)
    }
    
    private func clearButtonImage() -> some View {
        Image(systemName: "x.circle.fill")
            .imageScale(.large)
            .tint(.secondary)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Content View")
        }
        .frame(maxWidth: .infinity)
        .frame(maxHeight: .infinity)
        .background(.thinMaterial)
    }
}

struct AccessoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        AccessoryView()
            .background(.orange)
        AccessoryView()
            .preferredColorScheme(.dark)
            .background(.orange)
    }
}
