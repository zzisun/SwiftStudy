//
//  ProgressCardModel.swift
//  TodoList
//
//  Created by wooseok.suh on 2023/05/25.
//

import Foundation

final class ProgressCardModel: ObservableObject, Identifiable {

    @Published var title: String
    @Published var content: String
    @Published var author: String

    init(title: String, content: String, author: String) {
        self.title = title
        self.content = content
        self.author = author
    }
}
