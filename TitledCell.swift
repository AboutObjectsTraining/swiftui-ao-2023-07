// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

struct TitledCell: View {
    let title: String
    @Binding var value: String
    @Binding var isEditing: Bool
    
    init(title: String, value: Binding<String>, isEditing: Binding<Bool> = .constant(false)) {
        self.title = title
        _value = value
        _isEditing = isEditing
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            if isEditing {
                TitleView(title: title)
                EditableField(title: title, value: $value)
            } else {
                StaticField(title: title, value: value)
            }
        }
    }
}

struct TitleView: View {
    let title: String
    
    var body: some View {
        Text("\(title)")
            .font(.caption)
            .foregroundColor(.brown)
    }
}

struct StaticField: View {
    let title: String
    let value: String
    
    var body: some View {
        TitleView(title: title)
        Text("\(value)")
    }
}

struct EditableField: View {
    let title: String
    @Binding var value: String
    @FocusState var isFocused: Bool
    
    var body: some View {
        TextField(title, text: $value)
            .focused($isFocused)
    }
}

#if DEBUG
struct TitledCell_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TitledCell(title: "Name", value: .constant("Fred Smith"), isEditing: .constant(false))
                .previewLayout(.sizeThatFits)
            TitledCell(title: "Name", value: .constant("Fred Smith"), isEditing: .constant(true))
                .previewLayout(.sizeThatFits)
        }
    }
}
#endif
