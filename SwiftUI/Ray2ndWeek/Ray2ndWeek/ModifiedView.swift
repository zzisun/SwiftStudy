//
//  ModifiedView.swift
//  Ray2ndWeek
//
//  Created by wooseok.suh on 2022/05/10.
//

import SwiftUI

struct ModifiedView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .backgroundStyle(color: .blue)
    }
}

struct ModifiedView_Previews: PreviewProvider {
    static var previews: some View {
        ModifiedView()
    }
}

struct BackgroundStyle: ViewModifier {
    var bgColor: Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: UIScreen.main.bounds.width * 0.3)
            .foregroundColor(.white)
            .padding()
            .background(bgColor)
            .cornerRadius(20)
    }
}

extension View {
    func backgroundStyle(color: Color) -> some View {
        self.modifier(BackgroundStyle(bgColor: color))
    }
}
