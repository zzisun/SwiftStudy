import WidgetKit
import SwiftUI
import Intents

struct TodoView: View {
    let data: TodoList
    
    var body: some View {
        VStack {
            Text(data.title)
            Text(data.content)
        }
    }
}

struct bbbEntryView : View {
    var entry: TodoListEntry
    
    var body: some View {
        TodoView(data: entry.todoList[1])
    }
}

struct TodoListEntry: TimelineEntry {
    var date = Date()
    let todoList: [TodoList]
}

struct TodoListProvider: TimelineProvider {
    typealias Entry = TodoListEntry
    
    func placeholder(in context: Context) -> TodoListEntry {
        TodoListEntry(todoList: ModelData.todoList)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (TodoListEntry) -> Void) {
        let entry = Entry(todoList: ModelData.todoList)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<TodoListEntry>) -> Void) {
        let currentDate = Date()
        
        let refreshDate = Calendar.current.date(byAdding: .minute, value: 30, to: currentDate)!
        
        let entry = Entry(date: currentDate, todoList: ModelData.todoList)
        let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
        completion(timeline)
    }
}

@main
struct bbb: Widget {
    static let kind: String = "bbb"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "bbb", provider: TodoListProvider()) { entry in
            bbbEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct bbb_Previews: PreviewProvider {
    static var previews: some View {
        bbbEntryView(entry: TodoListEntry(date: Date(), todoList: ModelData.todoList))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
