import SwiftUI

struct TodoRow: View {
    var todoList: TodoList
    
    var body: some View {
        HStack {
            Text(todoList.title)
            Text(":")
            Text(todoList.content)
        }
    }
}

struct TodoRow_Previews: PreviewProvider {
    static var todoList = ModelData().todoList
    
    static var previews: some View {
        TodoRow(todoList: todoList[0])
            .previewLayout(.fixed(width: 300, height: 70))
    }
}
