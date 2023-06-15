//
//  ProgressTitleView.swift
//  TodoList
//
//  Created by wooseok.suh on 2023/05/25.
//

import SwiftUI

struct ProgressTitleView: View {
    let title: String
    @Binding var listCount: Int

    var body: some View {
        HStack {
            Text(title)

            Circle()
                .overlay {
                    Text("\(listCount)")
                        .foregroundColor(Color.black)
                }
                .frame(height: 50)
                .foregroundColor(.gray)

            Spacer()

            Button(action:{}) {
                Image(systemName: "plus")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ProgressTitleView_Previews: PreviewProvider {
    static let title = "ABCD"
    static var previews: some View {
        ProgressTitleView(title: title, listCount: .constant(10))
    }
}
