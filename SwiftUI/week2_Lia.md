> 2022.05.10.화



## Contents

- [04. Buttons and Navigation](#04-Buttons-and-Navigation)
- [05. Using Advanced Pickers](#05-Using-Advanced-Pickers)
- [06. Group Styles With ViewModifiers](#06-Group-Styles-With-ViewModifiers)





## 04. Buttons and Navigation

> 왜 버튼 내부의 count는 바인딩 값이 아닐까?

- SwiftUI는 주로 클래스보다 구조체로 뷰를 그리고, @State를 통해 변경사항을 감시한다
  - 이는 SwiftUI가 @State의 속성 변경을 감시하고 있기 때문이다
  - View 내부의 body 변경이 감지되면, 뷰 자체가 다시 렌더링 된다
- @State는 마치 다른 언어의 포인터와 비슷해서 값을 수정하고자 할 때 바인딩 타입인 $property를 사용한다
  - 다만, 위에서 언급한 것처럼, 포인터와는 다르게 뷰를 다시 렌더링하게 하는 역할도 있는 것 같다



> binding이 없는 경우

```swift
struct ButtonView: View {
    @State var count = 0
    var body: some View {
        VStack{
            Text("Welcome to your second view")
            Text("Current count value: \(count)")
                .padding()
            Button(action: { // 함수 자체를 등록하니까 클로저
               self.count += 1
            }){
               Text("Tap to Increment count")                   
            }
        }
    }
}
```

> binding을 하는 경우

```swift
struct ContentView: View {
  @State var choice = 0
  var body: some View {
    Form {
      Section {
        Picker("Transit Modes", selection: $choice){
          ForEach( 0 ..< transitModes.count) { index in
            Text("\(self.transitModes[index])")
            }
          }.pickerStyle(SegmentedPickerStyle())
        Text("Current choice: \(transitModes[choice])")
      }
      Section { ... }
      Section { ... }
    }
  }
}
```

- Button(action: @escaping () -> Void, label: () -> Label))
  - 버튼의 액션은 escaping closure 타입으로, 함수를 받는다
- Picker(_ titleKey: LocalizedStringKey, selection: Binding<SelectionValue>, content: () -> Content))
  - 피커의 셀렉션은 비인팅 타입으로 값을 받는다
- 함께 생각한 결론?
  - 어떻게 동작하게 하는지 방법의 차이이지 않냐
  - UIKit에서도, 같은 동작을 Combine+@Published를 동해 하느냐, escaping closure 로 하느냐 방식이 나뉘었듯이
  - 그럼 왜 두 방식을 달리 했을까?
    - 버튼의 경우에는 특정 값을 받아서 동작을 처리하기 보단, 사용자가 버튼을 눌렀을 때의 행위를 직접 적어줘야 하기에 바인딩 타입보단 클로져를 받는 것 같고
    - 피커의 경우에는, 명백하게 어떤 세그멘트를 선택했는지를 인덱스로 받을 수 있기에 바인딩 값으로 전달하는 게 아닌가 싶었다



## 05. Using Advanced Pickers

> Form이 뭘까?

```swift
struct ContentView: View {
  var body: some View {
    Form {
      Section { ... }
      Section { ... }
      Section { ... }
    }
  }
}
```

[공식문서](https://developer.apple.com/documentation/swiftui/form/)

- iOS, macOS 등의 플랫폼에 맞춰 `form` 안에 있는 뷰들을 적절한 스타일로 맞춰주는 뷰



> 예시

<img src="https://docs-assets.developer.apple.com/published/9b9f14a16c5d9d1fed7b121071bdb262/17400/SwiftUI-Form-iOS@2x.png" alt="A form on iOS, presented as a grouped list with two sections. The" style="zoom:33%;" /> iOS     vs   macOS   <img src="https://docs-assets.developer.apple.com/published/cdbe25e36916e95c7d68402249d02bb4/17400/SwiftUI-Form-macOS@2x.png" alt="A form on iOS, presented as a vertical stack of views. At top, it shows" style="zoom:33%;" />



## 06. Group Styles With ViewModifiers

```swift
struct ContentView: View {
    var body: some View {
        Text("Perfect") // 관용적 표현
            .backgroundStyle(color: Color.red)
        Text("Dd")      // 직접 표현
            .modifier(BackgroundStyle(bgColor: Color.red))
    }
}

struct BackgroundStyle: ViewModifier {
    var bgColor: Color
    func body(content: Content) -> some View{
        content
        .frame(width:UIScreen.main.bounds.width * 0.3)
        .foregroundColor(Color.black)
        .padding()
        .background(bgColor)
        .cornerRadius(CGFloat(20))
    }
}

extension View {
    func backgroundStyle(color: Color) -> some View{
        self.modifier(BackgroundStyle(bgColor: color))
    }
}
```

- modifier를 만들고, 뷰를 익스텐션한 내부에 function으로 넣으면, 더 관용적으로 쓸 수 있다는 걸 알게 되었다















