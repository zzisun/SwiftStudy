import SwiftUI

struct ContentView: View {
    var body: some View {
        ProgressListView(title: "해야 할 일", cardList: [
            ProgressCardModel(title: "Title", content: "Content", author: "Author"),
            ProgressCardModel(title: "Title", content: "Content", author: "Author")
        ])
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
