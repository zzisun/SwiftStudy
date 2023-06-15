# chapter8

### 1. basic animation

#### Animation Type



- **linear:** The animation is performed at a constant speed for the specified duration.
- **easeOut:** The animation starts out fast and slows as the end of the sequence approaches.
- **easeIn:** The animation sequence starts out slow and speeds up as the end approaches.
- **easeInOut:** The animation starts slow, speeds up, and then slows down again.

- spring

  - 기본값 = response: Double = 0.55, dampingFraction: Double = 0.825, blendDuration: Double = 0

  - **response**: The stiffness of the spring, defined as an approximate duration in seconds. A value of zero requests an infinitely-stiff spring, suitable for driving interactive animations.

    **dampingFraction**: The amount of drag applied to the value being animated, as a fraction of an estimate of amount needed to produce critical damping.

    **blendDuration**: The duration in seconds over which to interpolate changes to the response value of the spring.

#### Animation method

```swift
extension View {
    /// Applies the given animation to this view when the specified value
    /// changes.
    ///
    /// - Parameters:
    ///   - animation: The animation to apply. If `animation` is `nil`, the view
    ///     doesn't animate.
    ///   - value: A value to monitor for changes.
    ///
    /// - Returns: A view that applies `animation` to this view whenever `value`
    ///   changes.
    @inlinable public func animation<V>(_ animation: Animation?, value: V) -> some View where V : Equatable
}
```

스유 튜토리얼 추가되었어요!! [링크](https://developer.apple.com/tutorials/swiftui/animating-views-and-transitions)

[animation 동작 설명](https://medium.com/simform-engineering/basics-of-swift-ui-animations-d1aa2485a5d9)

### 2. AnimateTriangle

protocol Shape

```swift
public protocol Shape : Animatable, View {

    /// Describes this shape as a path within a rectangular frame of reference.
    func path(in rect: CGRect) -> Path
}
```

Question) withAnimation은 modifier가 아닌 함수인데 Triangle instance를 어떻게 갱신하는가?

A)  `onTapGesture` modifier에서 새로운 Triangle instance가 생성된다.

```swift
				Triangle(multiplier: multiplier)
            .fill(.red)
            .frame(width: 300, height: 300)
            .onTapGesture { 
                withAnimation(.easeOut(duration: 1)) {
                    multiplier = .random(in: 0.3...1.5)
                }
            }
```



### 3. interpolatingSpring

- damping = 0으로 설정 시, 고정이 안됨

```swift
- mass: The mass of the object attached to the spring.
- stiffness: The stiffness of the spring.
- damping: The spring damping value.
- initialVelocity: the initial velocity of the spring, as a value in the range [0, 1] representing the magnitude of
the value being animated.
```



### GeometryReader

>  우선 GeometryReader는 그 자체로 ‘View’이며, container 안 View 스스로의 크기와 위치를 함수로 정의한다고 소개되어있다.



### KeyFrame

[TimeLineView](https://developer.apple.com/documentation/swiftui/timelineview) : A view that updates according to a schedule that you provide.