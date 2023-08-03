// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

final class CoolViewModel: ObservableObject {
    
    @Published private(set) var cellModels: [CellModel]
    @Published var text = ""

    init(cellModels: [CellModel] = []) {
        self.cellModels = cellModels
    }
}

// MARK: Intents
extension CoolViewModel {
    
    func addCell() {
        let cellModel = CellModel(text: text, color: .blue, offset: .zero)
        cellModels.append(cellModel)
    }
    
    func clearText() {
        text = ""
    }
    
    func bringToFront(cellModel: CellModel) {
        guard let index = cellModels.firstIndex(where: { $0.id == cellModel.id }) else { return }
        cellModels.remove(at: index)
        cellModels.append(cellModel)
    }
}

#if DEBUG
extension CoolViewModel {
    
    static let testModel = CoolViewModel(cellModels: testData)
    
//    static var testModel: CoolViewModel {
//        CoolViewModel(cellModels: testData)
//    }
}

let testData = [
    CellModel(text: "Hello World! 🌎🌏🌍", color: .purple, offset: CGSize(width: 20, height: 40)),
    CellModel(text: "Cool Cells Rock! 🍾🎉", color: .orange, offset: CGSize(width: 50, height: 110)),
    CellModel(text: "Carpe Cell! 🤜🏻💥", color: .indigo, offset: CGSize(width: 90, height: 180)),
]
#endif
