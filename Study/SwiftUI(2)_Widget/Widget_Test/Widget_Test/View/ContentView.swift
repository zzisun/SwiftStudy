import SwiftUI

struct ContentView: View {
    var todoList: [TodoList]
    
    var body: some View {
        TodoListView(todoList: todoList)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var data = ModelData().todoList
    static var previews: some View {
        ContentView(todoList: data)
            .previewLayout(.device)
            .previewDevice("iPhone 12")
    }
}
