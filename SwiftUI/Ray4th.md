## 숙제

EnvironmentObject
- 앱의 많은 뷰와 데이터를 공유해야 하는 경우
- 어디에서나 모델 데이터에 접근
- 데이터 변경시 자동으로 업데이트 상태 유지
- 얘를 사용하면 @ObservedObject 사용 안해도 된다는데요(?)
- [링크](https://seons-dev.tistory.com/entry/SwiftUI-EnvironmentObject%EB%A5%BC-%EC%82%AC%EC%9A%A9%ED%95%98%EC%97%AC-%EB%B7%B0%EA%B0%84%EC%97%90-%EB%8D%B0%EC%9D%B4%ED%84%B0-%EA%B3%B5%EC%9C%A0)

ObservedObject
- 복잡한 프로퍼티
- 로컬 프로퍼티가 아닌 외부 참조타입을 사용한다는 것 외에는 @State와 유사
- @ObservedObject와 함께 사용하는 타입은 ObservableObject 프로토콜을 따라야함
- @ObservedObject 데이터 변경 여부를 알리는 좋은 방법은 @Published 사용
- [링크](https://seons-dev.tistory.com/78)

## SwiftUI - List
- UIKit의 tableView와 비슷
- 목록(List) 인터페이스를 구현
- UIKit tableView의 cell이 SwiftUI List에서는 Row

## Static List

```swift
struct FamilyRow: View {
  var name: String
  
  var body: some View {
    Text("Family: \(name)")
  }
}

struct ContentView: View {
  var body: some View {
    List {
      FamilyRow(name: "Hohyeon")
      FamilyRow(name: "Moon")
      FamilyRow(name: "Jigom")
    }
  }
}
```

## Dynamic List
- 고유의 id를 가진 Identifiable을 채택하는 객체 or id로 사용할 값을 직접 파라미터로 제공
- 이외엔 Static List와 동일하게 구현

```swift
.List(["A", "B", "C", "D"], id: \.self) { }
```

```swift
struct Family: Identifiable {
  var id = UUID()
  var name: String
}

struct FamilyRow: View {
  var family: Family
  
  var body: some View {
    Text("Family: \(family.name)")
  }
}

struct ContentView: View {
  let first = Family(name: "Hohyeon")
  let second = Family(name: "Moon")
  let third = Family(name: "Jigom")
  
  var body: some View {
    let families = [first, second, third]
    
    return List(families) { family in
      FamilyRow(family: family)
    }
  }
}
```

## Item Order Changes in List
- editButton없이 불가능

```swift
struct ContentView : View {
  @State var users = ["지선", "지경", "수빈"]
  
  var body: some View {
    NavigationView {
      List {
        ForEach(users, id: \.self) { user in
          Text(user)
        }
        .onMove(perform: move)
      }
      .navigationBarItems(trailing: EditButton())
    }
  }
  
  func move(from source: IndexSet, to destination: Int) {
    users.move(fromOffsets: source, toOffset: destination)
  }
}
```

## Item Deletion in List
- editButton없이 가능

```swift
struct ContentView : View {
  @State var users = ["zzisun", "lia", "soo"]
  
  var body: some View {
    List {
      ForEach(users, id: \.self) { user in
        Text(user)
      }
      .onDelete(perform: delete)
    }
  }
  
  func delete(at offsets: IndexSet) {
    if let first = offsets.first {
      users.remove(at: first)
    }
  }
}

```

## List Style
- iOS 기준 (다른 os로 보면 더 있음)
- default와 plain은 모든 os에서 사용가능
- default와 plain의 차이점
  - default는 플랫폼에 따라 default style을 따라감
  - plain은 해당 스타일로 고정

<img width="931" alt="스크린샷 2022-07-12 오전 8 01 40" src="https://user-images.githubusercontent.com/74946802/178372999-fcdebd73-c557-484e-86f3-3a803db05b79.png">
<img width="895" alt="스크린샷 2022-07-12 오전 8 01 45" src="https://user-images.githubusercontent.com/74946802/178373015-06adbc25-1425-4b1b-8b00-b61405c19173.png">

