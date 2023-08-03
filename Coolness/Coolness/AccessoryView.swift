// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct AccessoryView: View {
    
    @EnvironmentObject var viewModel: CoolViewModel
        
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
        viewModel.addCell()
    }
    
    private func clear() {
        viewModel.clearText()
    }
}

// MARK: View Configuration
extension AccessoryView {
    
    private var addButton: some View {
        Button(action: addCell, label: addButtonImage)
    }
    
    private var textField: some View {
        ZStack(alignment: .trailing) {
            VStack {
                TextField("Type here...", text: $viewModel.text)
                    .textFieldStyle(.roundedBorder)
            }
            if !viewModel.text.isEmpty {
                Button(action: clear, label: clearButtonImage)
                    .padding(.trailing, 6)
            }
        }
//        .onAppear {
//            UITextField.appearance().clearButtonMode = .whileEditing
//        }
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

#if DEBUG
struct AccessoryView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            AccessoryView()
                .background(.orange)
            AccessoryView()
                .preferredColorScheme(.dark)
                .background(.orange)
        }
        .environmentObject(CoolViewModel.testModel)
    }
}
#endif
