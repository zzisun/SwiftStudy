//
//  ListView.swift
//  Ray2ndWeek
//
//  Created by wooseok.suh on 2022/05/10.
//

import SwiftUI

struct ListView: View {
    @State private var names = ["Ray", "Soo", "V", "Lia"]
    var body: some View {
        List {
            ForEach(names, id: \.self) {
                name in
                Text(name)
            }.onDelete(perform: removeName)
        }
        .navigationBarItems(trailing: EditButton())
        .navigationBarTitle(Text("Study Memebers"), displayMode: .inline)
    }
    
    func removeName(at offset: IndexSet) {
        names.remove(atOffsets: offset)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
