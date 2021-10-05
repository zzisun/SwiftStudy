import SwiftUI

struct ContentView: View {
    var body: some View {
        ListView(todoList: ModelData.todoList)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
