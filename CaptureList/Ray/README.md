## Capture List 학습
>  주변 환경의 범위에서 참조한 변수들을 얼마나 강하게 캡쳐해야하는지 명시하는 개념

1. 참조타입: 클로저의 강한참조 순환 문제를 해결하기 위해 사용
2. 값타입: 클로저 내부에서 외부 값을 참조할 때 참조하는 값이 변경되면 클로저 내부 참조 값도 변하기 때문에 이를 방지하기 위해 사용

### 클로저의 타입
> 참조타입에서 순환 참조 문제, 값타입에서도 참조 값 문제가 생기는 이유는 클로저 역시 참조 타입이기 때문

####  클로저 Reference Capture
> 값/참조 타입 구분 없이 Reference Capture

```swift
func testClosure() {
    var number: Int = 0
    print("Test #1 = \(number)")
    
    let closure = {
        print("Test #3 = \(number)")
    }
    
    number = 10
    print("Test #2 = \(number)")
    number = 20
    closure()
}

testClosure()
```
- number라는 외부 변수를 클로저 내부에서 사용하기 때문에 number를 캡쳐
- 이때 number라는 변수를 Reference Capture(참조)
- 따라서 클로저 실행 전에 외부 number 값을 변경하면 클로저 내부 값도 변경 

> 실행결과
<img width="161" alt="스크린샷 2021-07-11 오전 8 32 21" src="https://user-images.githubusercontent.com/74946802/125178740-8c90d700-e222-11eb-9b15-7b4089c0a6f9.png">

```swift
func testClosure2() {
    var number: Int = 0
    print("Test #1 = \(number)")
    
    let closure = {
        number = 20
        print("Test #3 = \(number)")
    }
    
    closure()
    print("Test #2 = \(number)")
}

testClosure2()
```
- 위와 같이 클로저 내부에서 값을 변경해도 클로저 외부 값이 변경

> 실행결과
<img width="153" alt="스크린샷 2021-07-11 오전 8 36 52" src="https://user-images.githubusercontent.com/74946802/125178808-26f11a80-e223-11eb-96d3-bc58ddd25eed.png">

####  클로저 with Capture List
> 값 타입으로 캡쳐하고 싶을 때는 ? Capture List 활용

```swift
func testClosure3() {
    var number: Int = 0
    print("Test #1 = \(number)")
    
    let closure = { [number] in
        print("Test #1 = \(number)")
    }
    
    number = 20
    print("Test #1 = \(number)")
    closure()
}

testClosure3()
```
- Capture List를 활용하면 클로저를 호출하는 순간이 아닌 캡처하는 순간 값을 저장
- 단, 상수로 캡처하기 때문에 클로저 내부에서 값을 변경할 수 없음

> 실행결과
<img width="135" alt="스크린샷 2021-07-11 오전 8 42 40" src="https://user-images.githubusercontent.com/74946802/125178897-f5c51a00-e223-11eb-97a7-937b89b79b00.png">

####  클로저 & ARC
> 그렇다면 참조타입 캡처시에는 캡처리스트가 필요없나? 

```swift
class CodeSquadMember {
    var name = ""
    
    lazy var getName: () -> String = {
        return self.name
    }
    
    init(name: String) {
        self.name = name
    }
 
    deinit {
        print("방출!")
    }
}

var zzisun: CodeSquadMember? = .init(name: "zzisun-Kim")
print(zzisun!.getName())

zzisun = nil
```
- zzisun이란 인스턴스를 만들고 getName 프로퍼티 호출
- 이후 zzisun을 사용할 일이 없어서 nil값을 주면?
- deinit이 호출되어야 하지만 호출되지 않음

> 클로저의 강한 순환 참조

- getName을 호출하는 순간, getName이란 클로저가 Heap에 할당 (해당 클로저를 참조)
- 그런데 이때, self라는 키워드를 통해 CodeSquadMember에 접근
- 클로저는 Reference Capture 순간 별도의 키워드가 없으면 강한 참조가 default
- 즉, CodeSquadMember의 Reference Count도 증가
- 클로저 < - > CodeSquadMember 사이의 강한 순환 참조 발생

> 이 때 필요한 것이 캡처리스트

```swift
lazy var getName: () -> String = { [unowned self] in
    return self.name
}

lazy var getName: () -> String? = { [weak self] in
    return self?.name
}
```

- 캡처리스트를 활용하여 self를 unonwed 또는 weak으로 캡처
- 이렇게 캡처리스트를 활용하면 deinit이 호출되는 것을 확인할 수 있음

> 실행결과
<img width="134" alt="스크린샷 2021-07-11 오전 8 54 46" src="https://user-images.githubusercontent.com/74946802/125179063-a67fe900-e225-11eb-8c4f-20f1e460697f.png">
