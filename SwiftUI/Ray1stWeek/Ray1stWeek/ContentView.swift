//
//  ContentView.swift
//  Ray1stWeek
//
//  Created by wooseok.suh on 2022/05/03.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    
    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(
                colors: [.red,
                         .orange,
                         .yellow,
                         .green,
                         .blue,
                         .purple
                        ]
            ), center: .center)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                ClockView()
                Spacer()
                CircleImageView()
                Spacer()
                ShapableImageView(shape: .rectangle, image: $text)
            }
            
            // padding이나 offset이 bold 후
            Text("SwiftUI 학습하기")
                .foregroundColor(.blue)
                .bold()
                .underline()
                .padding()
                .offset(x: 100, y: 140)
            
            TextField("image", text: $text)
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .medium, design: .default))
                .offset(x: 80, y: -130)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
