# SwiftUI Animation

## animation(_:value:)
- instance method이며 modifier
- some View를 받아서 해당 뷰에 애니메이션을 적용한 뷰를 return
- 두 개의 파라미터를 받음
- animation: 어떠한 animation을 수행할 것인가
- value: 어떠한 value값이 변했을 때 animation을 수행할 것인가
### animation 파라미터
- default: system으로 정의된 컴포넌트의 애니메이션
- linear: 시작부터 끝까지 동일한 속도의 애니메이션
- easeIn: 시작은 느렸다가 끝날 때 빨라지는 애니메이션
- easeOut: 시작은 빨랐다가 끝날 수록 느려지는 애니메이션
- spring: 스프링처럼 움직이는 애니메이션
### modifier의 이해
- modifier는 view타입을 받아서 modifier를 적용시킨 view를 return
- offset, opacity, color등을 적용시킨 view를 받아서 animation처리하면 animation으로 동작

```swift
struct TestView: View {
    @State private var isAnimation = true

    var body: some View {
        VStack {
            Rectangle()
                .foregroundColor(isAnimation ? .yellow : .red)
                .frame(width: isAnimation ? 50 : 100, height: isAnimation ? 50 : 100)
                .animation(.spring(response: 1,dampingFraction: 0.3 ,blendDuration: 40), value: isAnimation)

            Button("Animate") {
                isAnimation.toggle()
            }
        }
    }
}
```

## withAnimation()
- function
- view를 받는 modifier가 아니라 클로저 내부의 변화 값에 모든 애니메이션 처리

```swift
struct ContentView: View {
    @State var isAnimation = false
    
    var body: some View {
        VStack {
            Button("Animate") {
                withAnimation(.easeIn(duration: 1)) {
                    isAnimation.toggle()
                }
            }
            Rectangle().foregroundColor(.red)
                .frame(width: 100, height: 100)
                .opacity(isAnimation ? 0 : 1)
        }
    }
}
```



