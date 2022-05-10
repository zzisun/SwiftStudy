//
//  ButtonView.swift
//  Ray2ndWeek
//
//  Created by wooseok.suh on 2022/05/10.
//

import SwiftUI

struct ButtonView: View {
    @State private var count = 0
    var body: some View {
        VStack(spacing: 20) {
            Text("Button Test View")
                .padding()
            Text("\(count)")
            Button(action: {
                self.count += 1
            }) {
                Text("Increase Number")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(Capsule())
            }
        }.navigationTitle("Hi")
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
