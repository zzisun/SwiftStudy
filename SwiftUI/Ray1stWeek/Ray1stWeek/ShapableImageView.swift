//
//  ShapableImageView.swift
//  Ray1stWeek
//
//  Created by wooseok.suh on 2022/05/03.
//

import SwiftUI

struct ShapableImageView: View {
    private var shape: ShapeType
    @Binding private var image: String
    @Binding private var isHidden: Bool
    
    var body: some View {
        let currentShape = getShape(shape: shape)
        Image(image)
            .resizable()
            .clipShape(currentShape)
            .frame(width: 100, height: 100)
            .overlay(currentShape.stroke(Color.blue, lineWidth: 2))
            .isHidden(isHidden)
    }
    
    init(shape: ShapeType, image: Binding<String>) {
        self.shape = shape
        self._image = image
        self._isHidden = .constant(true)
        showOrHideView(name: $image)
    }
    
    private mutating func showOrHideView(name: Binding<String>) {
        if let _ = UIImage(named: name.wrappedValue) {
            self._isHidden = .constant(false)
        } else {
            self._isHidden = .constant(true)
        }
    }
}

struct ShapableImageView_Previews: PreviewProvider {
    static var previews: some View {
        ShapableImageView(shape: .rectangle, image: .constant("flower"))
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

extension View {
    func isHidden(_ hide: Bool) -> some View {
        return hide ? opacity(0) : opacity(1)
    }
}
