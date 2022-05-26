//
//  CustomVStack.swift
//  Ray3rdWeek
//
//  Created by wooseok.suh on 2022/05/26.
//

import SwiftUI

struct CustomVStack<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 5) {
            Circle()
                .fill(Color.red)
                .frame(width: 30, height: 30)
            content
            Circle()
                .fill(Color.blue)
                .frame(width: 30, height: 30)
        }
    }
}
