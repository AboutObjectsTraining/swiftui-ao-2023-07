// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct CellModel: Identifiable {
    let id: UUID = UUID()
    let text: String
    let color: Color
    var offset: CGSize
}
