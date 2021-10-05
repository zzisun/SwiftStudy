import SwiftUI

struct ListView: View {
    var todoList:[TodoList]
    var body: some View {
        List {
            ForEach (todoList) { row in
                RowView(information: row)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(todoList: ModelData.todoList)
    }
}
