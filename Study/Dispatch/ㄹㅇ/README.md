## Dispatch Rule
```swift
```swift
class SuperClass {
    func someMethod() { 
        //... 
    }
}

class SubClass: SuperClass {
    override func someMethod() {
        // ...
    }
}


let someProperty: SuperClass = SubClass()

someProperty.someMethod()
```

#### Static Dispatch(Direct Call)
- 변수의 명목상 타입에 맞춰서 메소드와 프로퍼티를 참조
- 이 경우 참조될 요소를 컴파일 타임에 결정
- 위의 예제에서 Parent의 메소드를 호출하는 경우가 이에 해당
- 컴파일 타임에 결정이 끝나기 때문에 성능상의 이점이 있으나, 자식 클래스의 요소 호출하고 싶으면 변수를 자식 타입으로 명시적 타입 캐스팅
- 따라서 프로그램이 다형성을 활용하기 어렵게 만드는 단점

#### Dynamic Dispatch(Indirect Call):
- 변수의 실제 타입의 맞춰서 메소드와 프로퍼티를 호출
- 코드상으로는 이것이 드러나지 않기 때문에 실제 참조될 요소는 런타임에 결정 
- 어떤 서브클래스가 들어와도 실제 타입에 맞는 요소를 참조하기 때문에 다형성 활용에 유리 
- 다만, 런타임에 실제 참조할 요소를 찾는 과정이 있기 때문에 Static Dispatch보다 성능상에서 손해를 보게 된다는 단점 (이 과정은 O(1)의 시간복잡도를 가지도록 구현)

## Swift에서는 Dynamic Dispatch
- Swift에서는 Dynamic Dispatch를 채택 (아닌 경우도 있음)
- 일반적인 경우에는 Dynamic Dispatch가 편리(성능을 신경써야 하는 코드에서는 dynamic Dispatch의 오버헤드 고려)
- Dynamic Dispatch의 가능성이 있는 코드에서는 컴파일러의 최적화가 제한

### 성능최적화의 3가지 방법

#### 오버라이드 될 필요가 없는 요소들에는 final 키워드
- final 키워드를 붙여서 선언된 클래스, 메소드, 프로퍼티는 오버라이드 불가
- 이렇게 되면 컴파일러는 Dynamic Dispatch를 사용하지 않아도 됨을 알고 최적화 진행

#### private 키워드
- private 키워드를 붙여서 선언하게 되면 해당 요소는 한 파일 내에서만 참조되는 것이 자동으로 보장
- 따라서 한 파일내에 해당 요소에 대한 오버라이드가 없는 경우 컴파일러가 이를 자동으로 Direct Call로 변경

#### WMO가 활성화된 경우 모듈 외부에서 선언에 접근 할 필요가 없을 때 internal 을 사용
- WMO(Whole Module Optimization)을 사용한다면 internal 선언만으로 final을 추론 가능(물론 모듈 내에 오버라이드가 없는 경우 한정)
- Swift는 기본적으로 모듈을 이루는 파일들을 개별적으로 컴파일 하기 때문에 다른 파일에서 오버라이딩이 일어났는지 알 수 없음
- 하지만 WMO를 활성화 하면 모듈 전체가 하나의 덩어리로 취급되어 컴파일 되기 때문에 이를 확인하고 더 강력한 추론 가능
- 이는 모듈 내의 internal 선언은 모듈 바깥에 드러나지 않아 오버라이딩이 불가능 하다는 것이 보장되기 때문

** 접근제어자는 개인앱 단위에서 별의미가 없을 수 있지만, 최적화에 민감해야하는 앱이라면 간과할 수 없는 부분
** 여러 파일을 하나의 파일처럼 컴파일하고 최적화하는 기능

## Static vs Dynamic Dispatch

- Static Dispatch는 컴파일 타임에 실제 호출할 함수를 결정할 수 있기 때문에 함수 호출 과정이 간단하고, 컴파일러가 이것을 최적화할 수 여지가 많음 
- 속도가 빠르다는 장점이 있지만, 참조 타입에 따라 호출될 함수가 결정이 되기 때문에 서브클래싱은 불가

- 반면 Dynamic Dispatch는 런타임에 호출될 함수를 결정
- 이를 위해서 Swift 에서는 클래스마다 vtable(Virtual Dispatch Table)이라는 것을 유지
- 이는 함수 포인터들의 배열로 표현되며, 하위 클래스가 메소드를 호출할 때 이 배열을 참조하여 실제 호출할 함수를 결정
- 이 모든 과정이 런타임에 결정되기 때문에 Static Dispatch에 비하면 추가적인 연산이 필요할 수밖에 없고, 컴파일러가 최적화 할 여지도 많지 않음

#### Value Type Dispatch
- Value Type에 해당하는 struct와 enum은 상속을 사용할 수 없다는 특징
- 즉, static Dispatch의 단점인 서브클래싱이 불가능하다는 단점이 적용되지 않음
- 따라서 Value Type에는 Static Dispatch가 적용

#### Reference Type Dispatch
- Reference Type에 해당하는 class는 반대로 항상 상속의 가능성에 노출
- 따라서 Dynamic Dispatch를 사용
- 그 대신 오버라이딩이 되지 않는다는 것을 컴파일러가 알 수 있다면, 컴파일러가 이를 Static Dispatch로 변경 가능

#### Protocol Dispatch
- 프로토콜은 구현체를 제공하지 않고, 선언부만 제공 (물론 extension을 통하면 구현 가능)
- 따라서 프로토콜을 채택한 타입은 이를 구현해야 하며, 프로토콜을 통해 호출하는 메소드는 프로토콜을 채택한 타입들이 실제로 구현한 메소드들
- 그런데 프로토콜 타입의 참조로만 이들을 사용해야 한다면, 해당 인스턴스의 타입에 맞는 메소드를 호출
- 이를 위해 프로토콜은 고유의 vTable을 가지게 되며, 특별히 이를 Witness Table이라고 함
- 즉, 프로토콜 역시 Dynamic Dispatch를 사용

#### Extension Dispatch
- Swift는 모든 타입에서 Extension으로 기능을 추가가능
(1) 값 타입 : 역시 상속 가능성이 없기 때문에 Static Dispatch로 수행
(2) 참조 타입: extension으로 클래스에 추가 기능을 구현할 경우에는 오버라이드 여부에 따라 다음과 같은 규칙 적용

- 하위 메소드를 오버라이드 하는 경우 
- 기본적으로 extension에서는 메소드 오버라이드를 금지
- 이는 클래스 본체에 선언된 메소드를 오버라이드 하는 것과 extension에서 선언된 메소드를 오버라이드 하는 것 모두 포함 
- 이러한 기능을 사용하기 위해서는, Objective-C 런타임 활용 필요

- 오버라이드 하거나, 오버라이드 되지 않는 경우
- 자기 자신 뿐 아니라 하위 타입에서도 동일한 메소드를 참조함을 보장
- 따라서 클래스 타입이여도 Static Dispatch가 가능

(3) 프로토콜 타입: 프로토콜 역시 extension을 통해 기능을 추가가능 이 때, 프로토콜 본체에 선언된 멤버의 디폴트 구현체를 제공해주거나 프로토콜 본체에는 없는 기능을 추가적으로 제공가능

- 본체에 선언된 멤버의 디폴트 구현체를 제공하는 경우
- 하위 클래스들이 메소드들을 구현하고 있음이 반드시 보장
- 설령 구현하지 않았다 하더라도 디폴트 메소드를 이용가능
- 따라서 Witness Table을 이용한 Dynamic Dispatch

- 본체에 없는 기능을 추가한 경우
- 본체에 선언하지 않고 extension으로 추가한 메소드들은 Witness Table을 이용불가
- 즉, Dynamic Dispatch를 사용할 수 없고, Static Dispatch가 적용
