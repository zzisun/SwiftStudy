import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (TodoListEntry) -> Void) {
        let entry = TodoListEntry(date: Date(), todoList: ModelData().todoList)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<TodoListEntry>) -> Void) {
        var entries: [TodoListEntry] = []
        
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = TodoListEntry(date: Date(), todoList: ModelData().todoList)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func placeholder(in context: Context) -> TodoListEntry {
        TodoListEntry(date: Date(), todoList: ModelData().todoList)
    }
}

struct TodoListEntry: TimelineEntry {
    let date: Date
    let todoList: [TodoList]
}

struct widEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        Text(entry.todoList.first!.content)
    }
}

@main
struct wid: Widget {
    let kind: String = "wid"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            widEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct wid_Previews: PreviewProvider {
    static var previews: some View {
        widEntryView(entry: TodoListEntry(date: Date(), todoList: ModelData().todoList))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
