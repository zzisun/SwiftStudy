> 2022.05.26.목



## Contents

- [07. Separating presentation from content with ViewBuilder](#07-Separating-presentation-from-content-with-ViewBuilder)
- [08. Simple graphics using SFSymbols](#08-Simple-graphics-using-SFSymbols)
- [09. Integrating UIKIt into SwiftUI](#09-Integrating-UIKIt-into-SwiftUI)





## 07. Separating presentation from content with ViewBuilder

> ViewBuilder란?

- 클로저로 뷰를 받아서 하나 이상의 자식뷰를 만들어주는 함수 빌더
- `init` 에서 뷰를 받거나, `computed property`나 `뷰 생성 메소드` 에 @ViewBuilder를 적으므로 여러개의 뷰를 감쌀 수 있다

> init

```swift
struct CustomLabel<Content: View>: View {
    let content: Content
    let color: Color
  
    init(color: Color = .clear, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.color = color
    }
    var body: some View {
            HStack {
                Circle()
                    .fill(color)
                    .frame(width:20, height:30)
                Spacer()  
                content
                
            }
        .padding()
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            CustomLabel(color: .blue) {
                Text("some text here")
                Rectangle()
                .fill(Color.red)
                .frame(width: 40, height: 40)
            }
            CustomLabel {
                Text("Another example")
            }
            
        }
    }
}
```



> computed property

```swift
struct ContentView: View {
                
    @ViewBuilder // implicit 
    var body: some View {
        Text("Zedd")
        Text("Zedd")
        Text("Zedd")
        Text("Zedd")
        Text("Zedd")
        Text("Zedd")
        Text("Zedd")
        Text("Zedd")
    }
}

struct ContentView: View {
                
    var body: some View { 
        manyTexts
    }
    
    @ViewBuilder // ⬅️
    var manyTexts: some View { // ✅
        Text("Zedd") 
        Text("Zedd")
        Text("Zedd")
        Text("Zedd")
        Text("Zedd")
        Text("Zedd")
        Text("Zedd")
        Text("Zedd")
    }
}
출처: https://zeddios.tistory.com/1324 [ZeddiOS:티스토리]
```

- body 프로퍼티는 암시적으로 @ViewBuilder로 선언되어 있다
- 여러 뷰를 생성하는 경우, 가독성을 위해 따로 떼어내고 싶다면 computed property나 메소드에 @ViewBuilder를 명시하기만 하면 된다



> 왜 10개이지? 그리고 ForEach로 여러개 넣을 수 있는 것 같은데

- buildBlock 의 매개변수 최대 개수는 10개 이므로, ViewBuilder 에 전달할 수 있는 뷰의 개수도 10개이다. [출처](https://velog.io/@budlebee/SwiftUI-ViewBuilder)
- 개수를 extension으로 늘리는 방법이 있긴 함 ([참고](http://blog.eppz.eu/more-than-10-views-in-swiftui/))





## 08. Simple graphics using SFSymbols

- 이야~ 색을 저렇게 넣을 수 있구나





## 09. Integrating UIKIt into SwiftUI



















