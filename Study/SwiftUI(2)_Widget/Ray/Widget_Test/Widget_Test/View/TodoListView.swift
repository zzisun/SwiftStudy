import SwiftUI

struct TodoListView: View {
    
    var todoList: [TodoList]
    
    var body: some View {
        List {
            ForEach (todoList) { list in
                TodoRow(todoList: list)
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var todoList = ModelData().todoList
    
    static var previews: some View {
        TodoListView(todoList: todoList)
    }
}
