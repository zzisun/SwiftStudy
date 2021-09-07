## 이니셜라이저

- 클래스, 구조체, 열거형 인스턴스를 사용하기 위한 준비 작업
- 저장 프로퍼티의 초기 값을 설정
- 초기화 작업이 완료되면 메모리에 인스턴스가 생성

### 이니셜라이저의 대원칙

- 스위프트는 에러에 대한 안전을 최우선으로 한다.
- 빈 메모리에 접근하게 된다면 예기치 못한 에러가 발생할 수 있다.
- 타입 내부에 프로퍼티가 있다면, 해당 프로퍼티에는 무조건 값이 있다는 것을 보장해야한다.

### 이니셜라이저 & 초기화

```swift
ini() {
  // 필요한 초기화 코드를 작성 
}
```

- 단, 항상 초기 값을 가진다면 프로퍼티 선언과 동시에 값을 할당하는 것이 좋다.
- 프로퍼티 초기화를 해당 선언시점과 더 밀접하게 연결 => 더 짧고 명확한 이니셜라이저
- 프로퍼티의 타입이 추론되기 때문에 코드가 짧아진다.

### 옵셔널 타입

- 프로퍼티를 옵셔널 타입으로 선언한 경우, 초기값이 없어도되고 나중에 추가도 가능
- 초기화 과정이 없으면 자동으로 nil로 초기화

### 실패 가능한 이니셜라이저

- ?????

### 구조체의 이니셜라이저

- 구조체는 기본적으로 제공되는 2가지 이니셜라이저가 존재
  1. 멤버와이즈 이니셜라이저: 프로퍼티를 매개변수로 가지는 이니셜라이저
  2. 기본 이니셜라이저: 매개 변수가 없는 이니셜라이저
- 구조체 내에서 프로퍼티가 하나라도 초기화되지 않은 경우, 멤버와이즈 이니셜라이저가 제공
- 프로퍼티가 모두 초기화되어있는 경우 기본 이니셜라이저도 제공
- 단, 속성이 모두 let으로 초기화되어 있는 경우 멤버와이즈 이니셜라이저는 제공되지 않음

```swift
struct Sample {
    var species: String = "하하"
}

let sample = Sample(speciesString: “하하”) // 멤버와이즈 이니셜라이저
let sample = Sample() // 기본 이니셜라이저
```

### 열거형의 이니셜라이저

- 열거형은 rawValue가 있는 경우, rawValue로 부터 열거형 인스턴스를 생성할 수 있는 실패가능한 이니셜라이저가 기본으로 제공
- 열거형 case들을 초기화 해주는 것은 가능하지만, rawValue는 변할 수 없는 값이기 때문에 초기화 해줄 수 없다.

```swift
enum PowerRanger: String {
    case red
    case blue = "블루"
    case black
    
    init(call: Character) {
        switch call {
        case "r", "R" : self = .red
        case "b", "B" : self = .blue
        default: self = .black
        }
    }
}
let callToDoctor = PowerRanger(call: "R") // red
let callToDoctor2 = PowerRanger(rawValue: "레드") //nil
let callToDoctor3 = PowerRanger(rawValue: "블루") //blue
```

### 값 유형의 이니셜라이저 익스텐션

- 값 타입을 위한 사용자 이니셜라이저를 정의하면, 기본 이니셜라이저와 멤버와이즈 이니셜라이저를 사용할 수 없음
- 이니셜라이저의 복잡성을 낮추고, 이니셜라이저가 의도하지 않게 사용되는 것을 방지하기 위함
- 사용자 지정 이니셜라이저를 사용하면서 기본 또는 멤버와이즈 이니셜라이저도 사용하고 싶다면, 사용자 이니셜라이저를 익스텐션에 구현하면 가능

```swift
struct Sample {
    var name: String
    var number: Int

    init(anotherNumber: Int) {
        self.name = "SK"
        self.number = anotherNumber
    }
}
let aiden = Sample(name: "Aiden", number: 1)
// 오류: 사용자가 구조체 내부에 이니셜라이저를 구현하였기 때문에 멤버와이즈 이니셜라이저는 사용할 수 없다.
let sk = Sample(anotherNumber: 2) // Sample(name: "SK", number: 2)
//================================================================
struct Sample {
    var name: String
    var number: Int
}
extension Sample {
    init(anotherNumber: Int) { // init은 매개 변수의 이름으로 식별하기 때문에 이름이나 타입을 다르게 해줘야한다.
        self.name = "SK"
        self.number = anotherNumber
    }
}
let aiden = Sample(name: "Aiden", number: 1) // Sample(name: "SK", number: 1)
let sk = Sample(anotherNumber: 2) // Sample(name: "SK", number: 2)
```

### 클래스의 이니셜라이저

- 클래스가 부모 클래스에서 상속한 모든 프로퍼티를 모함하여 모든 클래스의 저장 프로퍼티는 초기화하는 동안 초기 값을 지정해줘야 한다.
- 스위프트는 모든 저장 프로퍼티가 초기 값을 가지는 데에 편리하도록 클래스 유형에 대해 두 가지 이니셜라이저를 제공한다.

### 지정 이니셜라이저 (Designated Initializer)

- 클래스의 모든 저장프로퍼티를 초기화 한다.
- 부모 클래스의 이니셜라이저를 호출할 수 있다.
- 클래스 내부에는 반드시 한 개 이상의 지정 이니셜라이저가 있어야 한다.

```swift
init(매개 변수) {
  // 구현부
}
```

### 편의 이니셜라이저 (Convenience Initializer)

- 지정 이니셜라이저의 일부 매개 변수의 기본 값을 설정하여 초기화한다.
- 더 적은 입력으로 초기화를 편리하게 할 수 있게 해준다.

```swift
convenience init(매개 변수) {
  // 구현부
}
```

```swift
class Person {
    var name: String
    var age: Int
      
    init(name: name, age: age){
        self.name = name
          self.age = age
    }
      
    convenience init(name: name){
          self.init(name: name, age: 27) // 지정 이니셜라이저 호출
    }
}

let aiden = Person(name: "Aiden")// Person(name: "Aiden", age: 27)
//==========================================================================
// convenience init을 사용하고 싶지 않다면 프로퍼티에 초기값을 할당해줘도 된다.
class Person {
    var name: String
    var age: Int = 27
      
    init(name: name){
          self.name = name
    }
}

let aiden = Person(name: "Aiden")// Person(name: "Aiden", age: 27)
```

### 이니셜라이저 위임의 규칙

1. 지정 이니셜라이저는 반드시 부모 클래스의 이니셜라이저를 호출해야한다.
2. 편의 이니셜라이저는 반드시 같은 클래스의 이니셜라이저를 호출해야한다.
3. 즉, 편의 이니셜라이저는 지정 이니셜라이저를 호출해야한다.

### 상속 초기화

- 자식 및 부모 클래스의 모든 저장 프로퍼티에 초기 값을 지정한다.
- 자식 및 부모 클래스의 저장 프로퍼티 값을 변경한다.
- 이 시점부터 메서드 및 연산 속성을 사용하여 초기화를 진행한다.

```swift
class Shape {
    var numberOfSides: Int = 0
    var name: String

    init(name: String) {
       self.name = name
    }
}

class Square: Shape {
    var sideLength: Double = 0.0

    init(sideLength: Double, name: String) {
        self.sideLength = sideLength // 1. 자식 클래스의 속성에 값 할당
        super.init(name: name) // 부모 클래스의 이니셜라이저 호출
        numberOfSides = 4 // 부모 클래스가 정의한 속성 값 변경
    }
}
```
- 부모 클래스를 호출하기 전 자식 클래스의 프로퍼티를 초기화 하여야 한다.
- 부모 클래스에 있는 프로퍼티에 따로 값을 할당하기 위해선 부모 클래스의 이니셜라이저를 먼저 호출해야 한다.
- 단, 자식 클래스의 프로퍼티가 초기화 된 경우 자식 클래스의 프로퍼티에 값을 할당하는 구문은 뒤에 동작하여도 된다.

### 이니셜라이저 상속

- 스위프트는 기본적으로 자식 클래스에서 부모 클래스의 이니셜라이저를 상속하지 않는다.
- 무분별하게 상속돼 복잡해지면서 자식 클래스를 잘못 초기화히는 상황을 막기 위함이다.
- 단, 특정 조건을 만족하면 이니셜라이저를 상속한다.

### 이니셜라이저 상속하기 위한 조건

- 자식 클래스가 지정 이니셜라이저를 정의하지 않은 경우 지정 이니셜라이저를 상속 받는다.
- 자식 클래스가 부모 클래스의 지정 이니셜라이저를 모두 구현(상속 또는 오버라이드)한 경우 편의 이니셜라이저를 상속 받는다.  

```swift
class Food {
    var name: String
    init(name: String) { // Food 클래스의 지정 이니셜라이저
        self.name = name // Food 클래스의 모든 프로퍼티를 초기화
    }
    convenience init() { // Food 클래스의 편의 이니셜라이저
    // 지정 이니셜라이저를 호출하여 매개 변수에 "[이름 없음]"이란 값 전달
          self.init(name: "[이름 없음]")
    }
}

let namedMeat = Food(name: "베이컨") // namedMeat의 name은 “베이컨"
let mysteryMeat = Food() // mysteryMeat의 name은 “[이름 없음]"
//================================================================
class RecipeIngredient: Food { // Food를 상속받은 클래스
    var quantity: Int
    // RecipeIngredient 클래스의 지정 이니셜라이저
    init(name: String, quantity: Int) { 
        self.quantity = quantity
        super.init(name: name) // 부모 클래스의 이니셜라이저를 호출하여 name에 값 전달
    }
    // 부모 클래스의 이니셜라이저와 겹치기 때문에 override 키워드를 써서 오버라이드 (식별자는 매개변수의 타입과 이름으로 구분하기 때문)
    override convenience init(name: String) { 
        self.init(name: name, quantity: 1)
    }
}
// 부모 클래스의 모든 이니셜라이저를 구현한 경우, 부모 클래스가 가진 컨비니언스 이니셜라이저를 상속 받는다.
let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "베이컨")
let sixEggs = RecipeIngredient(name: "달걀", quantity: 6)

//================================================================
// RecipeIngredient를 상속 받은 클래스
// 새로 추가된 모든 프로퍼티가 기본 값을 가지고 있으며 별도의 이니셜라이저를 적용하지 않았으므로 부모 클래스의 모든 이니셜라이저를 자동으로 상속한다.
class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
}

var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "베이컨"),
    ShoppingListItem(name: "달걀", quantity: 6),
]
// 참고: "[이름 없음]"을 "오렌지 쥬스"로 변경 및 구매한 것으로 변경
breakfastList[0].name = "오렌지 쥬스" 
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}
// 1 x 오렌지 쥬스 ✔
// 1 x 베이컨 ✘
// 6 x 달걀 ✘
```
### 필수 이니셜라이저(Required Initializer)

- 모든 자식 클래스에서 반드시 구현해야 하는 이니셜라이저
- required 키워드를 붙여 사용 가능하고 자식 클래스에서 구현할 때에도 required 키워드를 붙여야 한다.
- required는 오버라이드를 기본으로 포함하고 있다.

```swift
class SomeClass {
    required init() {
        // 이 곳에 이니셜라이저 구현 작성하기
    }
}

class SomeSubclass: SomeClass {
    required init() {
        // 이 곳에 자식 클래스의 필수 이니셜라이저 구현 작성하기
    }
}
```
