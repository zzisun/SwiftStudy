## Closure
> 함수를 func키워드가 아니라, 변수에 선언하는 형태
- 코드를 간결하고, 직관적으로 작성하는데 도움

#### func 함수
```swift
var count = 0
func increaseCount() {
    count += 1
}
increaseCount()
increaseCount()
print(count) // 2
```

#### Closure 함수
```swift
var count = 0
let increaseCount = {
    count += 1
}
increaseCount()
increaseCount()
print(count) // 2
```

### Closure의 기본형태
> head와 body로 구성
```swift
var closure = { header in body }
```
- 헤더는 인자와 리턴타입을 명시
- 바디는 클로저 호출시 실행되는 함수의 내용 작성
- in은 header와 body를 나누는 기능

```swift
let names = ["Ray", "zzisun", "Lia"]
let numbers = [1, 4, 0]

names.sorted(by: (String, String) -> Bool)
numbers.sorted(by: (Int, Int) -> Bool)
```

```swift
let names = ["Ray", "zzisun", "Lia"]

func descending(_ s1:String, _ s2:String) -> Bool {
    return s1 > s2
}

var result1 = names.sorted(by: descending)
var result2 = names.sorted(by: { (s1: String, s2:String) -> Bool in return s1 < s2 })
```

### Closure의 축약 형태

#### 데이터 타입 생략(Type Inferring)
> 배열의 데이터 타입을 가진 인자 두개로 나뉘기 때문에, 타입 추론이 가능
```swift
names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 < s2 })
// 데이터 타입 생략
names.sorted(by: { (s1, s2) in return s1 < s2 })
```

#### return keyword 생략
> Single Expression Closure는 `return` 키워드를 생략가능
```swift
names.sorted(by: { (s1, s2) in s1 < s2 })
```

#### Short-hand argument name
> 클로저의 내부 인자는 이름을 정의하지 않아도 '$0', '$1' 순서로 사용가능
```swift
names.sorted(by: { $0 < $1 })
```

#### Operator Methods를 통한 축약
> 연산자를 활용하여 축약가능
```swift
names.sorted(by: <)
names.sorted(by: >)
```

## Escaping Closure
> 클로저가 함수의 인자로 전달됐을 때, 함수의 실행이 종료된 후 실행되는 클로저
- 즉, 메서드의 라이프 사이클 내에 실행하여 끝내지 않고, 메서드 scope의 외부에 전달하고자 할 때 활용
- 주로 통신할 때 주요하게 사용할 수 있음
- 서버와의 통신시에 비동기 방식으로 코드를 작성 -> 통신 완료를 기다리지 않고 다음 작업으로 넘어갈 때
- 통신이 완료됐을 때, 클로저를 호출하여 데이터를 전달받을 수 있음

### @escaping
> @escaping을 붙여도 escaping 또는 non-escaping으로 활용 가능
- 그렇다면 왜 구분해서 사용하는가?
- 컴파일러의 performance 최적화 때문
- non-escaping 클로저는 컴파일러가 클로저의 실행이 언제 종료되는지 알 수 있음
- 즉, 클로저에서 사용하는 특정 객체에 대한 retain, release 등의 처리를 생략해 객체의 라이프 사이클 효율적 관리 가능
- esacping 클로저는 함수 밖에서 실행되기 때문에 클로저가 함수 밖에서도 실행되는 것을 보장하기 위해, 클로저에서 사용하는 객체에 대한 추가적인 참조 사이클 관리 등을 해줘야 함
