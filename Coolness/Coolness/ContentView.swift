// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var viewModel: CoolViewModel
    
    var body: some View {
        ZStack {
            ForEach(viewModel.cellModels) { cellModel in
                Cell(cellModel: cellModel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(.regularMaterial)
    }
}


#if DEBUG
struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        CoolView()
            .environmentObject(CoolViewModel.testModel)
        ContentView()
            .environmentObject(CoolViewModel.testModel)
            .background(.orange)
    }
}
#endif
