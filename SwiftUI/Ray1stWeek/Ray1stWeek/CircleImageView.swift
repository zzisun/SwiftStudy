//
//  CircleImageView.swift
//  Ray1stWeek
//
//  Created by wooseok.suh on 2022/05/03.
//

import SwiftUI

struct CircleImageView: View {
    var body: some View {
        Image(uiImage: getUIImage(image: "flower"))
            .resizable()
            .frame(width: 300, height: 200)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.red, lineWidth: 2))
            .shadow(radius: 10)
    }
}

func getUIImage(image: String) -> UIImage {
    guard let img = UIImage(named: image) else { return UIImage() }
    return img
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView()
    }
}
