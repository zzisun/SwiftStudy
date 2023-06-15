## AsyncImage
- URLSession Instance를 사용하여 할당된 URL에서 이미지를 가져오는 기능
- 디바이스 실행 후 약간의 시간 후에 이미지를 나타나게 할 때 사용

```swift
import SwiftUI
 
struct ContentView: View {
    private let imageName: String = "https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FlI00H%2FbtqXQ6wtwVP%2FUrgHPkbHKxeqWwHIYzoaK1%2Fimg.png"
    
    var body: some View {
        AsyncImage(url:URL(string: imageName)) 
    }
}
```

- scale의 값이 클 수록 이미지가 작아짐
```swift
    var body: some View {
        AsyncImage(url:URL(string: imageName), scale: 2.0)
    }
```

- placeholder를 사용할 수 있음
- resizable modifier는 Image에 사용 
- AsyncImage에는 사용 불가
- placeholder를 사용할 수 있음
```swift
    var body: some View {
        AsyncImage(url:URL(string: imageName)) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Image(systemName: "paperplane.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200)
                .foregroundColor(.blue.opacity(0.6))
        }
        .padding(20)
    }
```

- if-let 또는 switch 활용가능
```swift
AsyncImage(url: URL(string: "https://example.com/icon.png")) { phase in
    if let image = phase.image {
        .resizable()
        .aspectRatio(contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding() // Displays the loaded image.
    } else if phase.error != nil {
        Text(.localizedDescription)
    } else {
        emptyView() // Acts as a placeholder.
    }
}
```

```swift
AsyncImage(url: URL(string: imageName)) { phase in
    switch phase {
    case .success(let image):
        image
         .resizable()
         .padding()
        
    case .failure(let error):
        VStack {
            Image(systemName: "photo.circle.fill")
                .IconModifier()
            Text("error code : \(error.localizedDescription)")
                .padding()
                .lineLimit(3)
        }
        
    case .empty:
        Image(systemName: "photo.circle.fill")
            .IconModifier()
        
    @unknown default:
        defaultView()
    }
}
```

- transition / transaction 옵션을 통해 애니메이션 구현 가능
- transaction
  - response: dampingFraction이 0일 때 하나의 진동을 완료하는 데 걸리는 시간
  - dampingFraction: spring이 얼마나 빨리 멈추는지 제어(값이 0이면 animation이 멈추지 않음)
  - blendDuration: animation 사이 transition의 길이를 정함(값이 0일 경우 blending을 끔)
  
```swift
var body: some View {
    AsyncImage(url: URL(string: imageName), transaction: Transaction(animation: .spring(response: 0.7, dampingFraction: 0.5, blendDuration: 0.3))) { phase in
        switch phase {
        case .success(let image):
            image.imageModifier()
                .transition(.move(edge: .bottom)) //아래에서 위로 튀어오르는 효과
        case .failure(_):
            Image(systemName: "exclamationmark.icloud.fill")
                .iconModifier()
        case .empty:
            Image(systemName: "photo.circle.fill")
                .iconModifier()
        @unknown default:
            ProgressView()
        }
    }
    .padding(30)
}
```
