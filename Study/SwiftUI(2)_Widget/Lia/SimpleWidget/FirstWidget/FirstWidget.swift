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
        
        UserFetcher().excute{ result in
            switch result {
            case .success(let users):
                entries = users
            case .failure(let error):
                print(error)
            }
        }

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let interval = 5
        for index in 0 ..< entries.count {
            entries[index].date = Calendar.current.date(byAdding: .second, value: index * interval, to: currentDate)!
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

        VStack(alignment: .leading) {
            Text(model.date, style: .time)
            
            Text(model.name)
                .font(.largeTitle)
                .foregroundColor(.brown)
            
            Text(model.email)
                .font(.caption)
                .foregroundColor(.black)
        }
        .background(.white)
        .padding()
        .cornerRadius(6)
    }
}

struct FirstWidget_Previews: PreviewProvider {
    static var previews: some View {
        FirstWidgetEntryView(model: snapshotEntry)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}




final class UserFetcher {
    
    private var networkManager = NetworkManager()
    private var cancelBag = Set<AnyCancellable>()
    
    func excute(completion: @escaping (Result<[UserWidget], NetworkError>) -> Void) {
        networkManager.get(path: "/user", type: [UserWidget].self)
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
