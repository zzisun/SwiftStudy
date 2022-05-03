//
//  ShapableImageView.swift
//  Ray1stWeek
//
//  Created by wooseok.suh on 2022/05/03.
//

import SwiftUI

struct ShapableImageView: View {
    @Binding var shape: ShapeType
    
    var body: some View {
        let currentShape = getShape(shape: shape)
        Image("flower")
            .resizable()
            .clipShape(currentShape)
            .frame(width: 100, height: 100)
            .overlay(currentShape.stroke(Color.blue, lineWidth: 2))
    }
    
    init(shape: Binding<ShapeType>) {
        self._shape = shape
    }
}

struct ShapableImageView_Previews: PreviewProvider {
    static var previews: some View {
        ShapableImageView(shape: .constant(.rectangle))
    }
}

struct AnyShape: Shape {
    
    private let _path: (CGRect) -> Path
    
    init<T: Shape>(_ wrapped: T) {
        _path = { rect in
            let path = wrapped.path(in: rect)
            return path
        }
    }
    
    func path(in rect: CGRect) -> Path {
        return _path(rect)
    }
}

enum ShapeType {
    case circle
    case rectangle
}

func getShape(shape: ShapeType) -> some Shape {
    switch shape {
    case .circle:
        return AnyShape(Circle())
    case .rectangle:
        return AnyShape(Rectangle())
    }
}
