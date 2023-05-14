import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TitleView(title: "TO-DO LIST")
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
