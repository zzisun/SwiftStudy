# SwiftUI + WidgetKit

* **멀티플랫폼** 지원을 하면서, 개발자들이 쉽게 iOS, iPadOS, macOS의 여러 플랫폼을 쉽게 다룰 수 있도록 하는 것이다.

  이를 위해 위젯의 유저 인터페이스와 WidgetKit은 SiwftUI에 포함되어 있다.

* 위젯은 최신상태를 유지하므로 최신정보를 한눈에 파악할 수 있다.

<img src="https://blog.kakaocdn.net/dn/c15g3D/btq8UddlBOT/6Zg2KPVUBd4OshWIeFQh20/img.png" width="500">



```swift
struct SimpleEntry: TimelineEntry {
    let date: Date
    let character: CharacterDetail
}

struct EmojiRangerWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        AvatarView(entry.character)
    }
}
```

먼저 시각과 함께 캐릭터를 넘겨주도록 SimpleEntry를 선언하였습니다.

그리고 앱에서 가져온 AvatarView를 보여주는 EmojiRangerWidgetEntryView를 선언하였습니다.

이때 provider가 전달한 entry에 해당하는 캐릭터를 그립니다.



# Widget(Configuration)

```swift
@main // 위젯의 시작점
struct EmojiRangerWidget: Widget {
    let kind: String = "EmojiRangerWidget"

    var body: some WidgetConfiguration {
        // static/dynamic configuration
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            // provider: 시간에 따라 위젯에 표시해야하는 데이터를 결정
            EmojiRangerWidgetEntryView(entry: entry) // 사용자에게 표시되는 SwiftUI View
            // 각각의 timeline entry에 도달하면 widgetkitdms content closure을 호출하여 위젯 내용을 띄운다.
        }
        .configurationDisplayName("Emoji Ranger Detail")
        .description("귀여운 아바타를 위젯에 추가하세요!")
        .supportedFamilies([.systemSmall]) // small size만 있도록 제한(3가지 크기가 있다.)
    }
}
```

### widget user-configurable

* staticConfiguration: user의 정보에 따라 바뀌는 속성이 있는 경우

* IntentConfiguration: user의 정보에 따라 바뀌는 속성이 없는 경우



# Provider

```swift
struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), character: .panda) 
    }

    // 위젯 현재상태 for 위젯추가시 미리보기 화면이 일시적으로 필요할 때 사용
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), character: .panda)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate)
//            entries.append(entry)
//        }
      
        // full timeline이 필요없으니 하나의 entry만 추가
        let entries: [SimpleEntry] = [SimpleEntry(date: Date(), character: .panda)]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}
```



### Provider: TimelineProvider

> timelineEntry들로 구성된 timeline을 생성하고 widgetKit에 알려준다
>
> timeline: 위젯 화면 업데이트 시기

* entry: date가 필수요소, 시간정보를 담고 있다
* 

* Timeline(entries: entries, policy: .atEnd)

  policy에는 timeline을 reload하는 atEnd, after(date:), never의 옵션이 있다.

  * atEnd: 마지막 entry가 끝난 후 이전과 같은 방법으로 timeline 생성

    entries = [1시, 2시, 3시] , 3시가 되면 entries = [3,4,5,6] 생성

  * after(date:) : 매개변수로 전달받은 시간에 timeline 업데이트

  * never: 마지막 entry가 끝난 후 새로운 타임라인을 요청하지 않음



## Demo

<img src="https://user-images.githubusercontent.com/60323625/136007863-a1dc217c-f25a-46f4-b34c-e0b64762c440.gif">


WWDC2020 Widget Code-along Tutorial을 진행했습니다.
[Widget Code-along1](https://developer.apple.com/videos/play/wwdc2020/10034)
[Widget Code-along1](https://developer.apple.com/videos/play/wwdc2020/10035)
[Widget Code-along1](https://developer.apple.com/videos/play/wwdc2020/10036)

