import SwiftUI

struct RowView: View {
    var information: TodoList
    
    var body: some View {
        Text(information.title + " : " + information.content)
    }
}

struct RowView_Previews:
    
    PreviewProvider {
    static var previews: some View {
        RowView(information: ModelData.todoList.first!)
    }
}
