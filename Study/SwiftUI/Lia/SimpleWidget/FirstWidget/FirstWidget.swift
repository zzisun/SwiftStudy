//
//  FirstWidget.swift
//  FirstWidget
//
//  Created by Lia on 2021/10/05.
//

import WidgetKit
import SwiftUI
import Combine

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

struct FirstWidgetEntryView : View {
    var model: UserWidget

    var body: some View {
        Text(model.date, style: .time)
    }
}

struct FirstWidget_Previews: PreviewProvider {
    static var previews: some View {
        FirstWidgetEntryView(model: snapshotEntry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}




final class UserFetcher {
    
    private var networkManager: NetworkManagerable
    private var cancelBag = Set<AnyCancellable>()
    
    init(networkManager: NetworkManagerable) {
        self.networkManager = networkManager
    }
    
    func excute(completion: @escaping (Result<[UserWidget], NetworkError>) -> Void) {
        networkManager.get(path: "/issues", type: [UserWidget].self)
            .receive(on: DispatchQueue.main)
            .sink { error in
                switch error {
                case .failure(let error): completion(.failure(error))
                case .finished: break
                }
            } receiveValue: { issues in
                completion(.success(issues))
            }.store(in: &cancelBag)
    }
    
}
