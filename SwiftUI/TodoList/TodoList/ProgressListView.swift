//
//  ProgressListView.swift
//  TodoList
//
//  Created by wooseok.suh on 2023/05/25.
//

import SwiftUI

struct ProgressListView: View {

    var title: String
    var cardList: [ProgressCardModel]

    var body: some View {
        List {
            ProgressTitleView(title: title, listCount: .constant(cardList.count))
            ForEach(cardList) { card in
                ProgressCardView(model: card)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.insetGrouped)
        }
    }
}

struct ProgressListView_Previews: PreviewProvider {
    static let cardList: [ProgressCardModel] = [
        ProgressCardModel(title: "Title", content: "Content", author: "Author"),
        ProgressCardModel(title: "Title", content: "Content", author: "Author")
    ]
    static var previews: some View {
        ProgressListView(title: "abcd", cardList: cardList)
    }
}
