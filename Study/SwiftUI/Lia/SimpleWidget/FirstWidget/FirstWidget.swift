//
//  FirstWidget.swift
//  FirstWidget
//
//  Created by Lia on 2021/10/05.
//

import WidgetKit
import SwiftUI


let snapshotEntry = UserWidget(
    date: Date(),
    id: 1,
    email: "Lia@316.com",
    name: "Lia",
    profileImage: "Lia"
)

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> UserWidget {
        snapshotEntry
    }

    func getSnapshot(in context: Context, completion: @escaping (UserWidget) -> ()) {
        let entry = snapshotEntry
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [UserWidget] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for index in 0 ..< 5 {
            entries[index].date = Calendar.current.date(byAdding: .hour, value: index, to: currentDate)!
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

@main
struct FirstWidget: Widget {
    let kind: String = "FirstWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FirstWidgetEntryView(model: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
