//
//  ProgressCardView.swift
//  TodoList
//
//  Created by wooseok.suh on 2023/05/25.
//

import SwiftUI

struct ProgressCardView: View {
    @ObservedObject var model: ProgressCardModel

    var body: some View {
        VStack(spacing: 10) {
            Text(model.title)
                .fontWeight(.bold)

            Text(model.content)

            Text(model.author)
                .foregroundColor(.gray)
        }

    }
}

struct ProgressCard_Previews: PreviewProvider {
    static let model = ProgressCardModel(title: "Title", content: "COntent", author: "author")
    static var previews: some View {
        ProgressCardView(model: model)
    }
}
