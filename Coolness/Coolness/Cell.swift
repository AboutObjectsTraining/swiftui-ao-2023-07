// Copyright (C) 2023 About Objects, Inc. All Rights Reserved.
// See LICENSE.txt for this project's licensing information.

import SwiftUI

extension CGSize {
    static func +(lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

struct Cell: View {
    @EnvironmentObject var viewModel: CoolViewModel
    
    let cellModel: CellModel
    
    @State private var isBouncing = false
    @State private var highlighted = false
    @State private var currentOffset = CGSize.zero
    @GestureState private var offsetAmount = CGSize.zero
    
    private var dragGesture: some Gesture {
        DragGesture()
            .updating($offsetAmount) { value, state, _ in
                state = value.translation
            }
            .onChanged { _ in
                highlighted = true
                viewModel.bringToFront(cellModel: cellModel)
            }
            .onEnded { value in
                currentOffset = currentOffset + value.translation
                highlighted = false
            }
    }
    
    var body: some View {
        Text(cellModel.text)
            .coolTextStyle(textColor: .white,
                           background: cellModel.color,
                           highlighted: highlighted)
            .offset(cellModel.offset + currentOffset + offsetAmount)
            .gesture(dragGesture)
            .onTapGesture(count: 2, perform: bounce)
            .onTapGesture(count: 1, perform: bringToFront)
            .bounceEffect(isBouncing)
    }
}

// MARK: - Intents
extension Cell {
    var duration: Double { 1 }
    var count: Int { 5 }
    
    private func bounce() {
        withAnimation(.easeInOut(duration: duration).repeatCount(count)) {
            isBouncing = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * Double(count)) {
            withAnimation(.easeInOut(duration: duration)) {
                isBouncing = false
            }
        }
    }
    
    private func bringToFront() {
        viewModel.bringToFront(cellModel: cellModel)
    }
}

// MARK: - Custom Modifiers
extension View {
    
    func bounceEffect(_ isBouncing: Bool) -> some View {
        modifier(BounceEffect(size: isBouncing ? 80 : 0))
    }
}

struct BounceEffect: GeometryEffect {
    var size: CGFloat
    
    var animatableData: CGSize.AnimatableData {
        get { CGSize.AnimatableData(size, size * 2) }
        set { size = newValue.first }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let translation = CGAffineTransform(
            translationX: animatableData.first,
            y: animatableData.second
        )
        
        return ProjectionTransform(translation)
    }
}


extension Text {
    
    func coolTextStyle(textColor: Color, background: Color, highlighted: Bool) -> some View {
        return self
            .font(.headline)
            .foregroundColor(textColor)
            .padding(.vertical, 9)
            .padding(.horizontal, 14)
            .background(background.opacity(highlighted ? 0.5 : 1))
            .cornerRadius(10)
            .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 3)
            )
    }
}

#if DEBUG
struct Cell_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
            .background(.orange)
            .previewDisplayName("Content View")
            .environmentObject(CoolViewModel.testModel)
    }
}
#endif
