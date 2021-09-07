# Initializer



### Designated Initializers and Convenience Initializers

* ***Designated initializers***

  > primary initializers  

  * 모든 속성 initialize
  * 적절한 superclass initializer 호출하여 process 진행
  * 적어도 한개 이상
  * "funnel" 포인트 

  <img src="https://user-images.githubusercontent.com/60323625/132272099-1741cbf6-9f82-40f1-af9f-fe6f2a044b0c.png" heigh="100" align="left">

* ***Convenience initializers***

  > secondary, supporting initializers

  * specific use case or input value type.
  * 반복되는 초기화 패턴에서 지름길 제공
  * 초기화를 보다 명확하게 할 때

  <img src="https://user-images.githubusercontent.com/60323625/132272108-f6d8a11e-bdac-40b1-a076-7d3384e11a5f.png" heigh="100" align="left">



### Initializer Delegation for Class Types

**Rule 1**

A designated initializer must call a designated initializer from its immediate superclass.

**Rule 2**

A convenience initializer must call another initializer from the *same* class.

**Rule 3**

A convenience initializer must ultimately call a designated initializer.

<img src="https://docs.swift.org/swift-book/_images/initializerDelegation02_2x.png" width="600" align="left">



### Two-Phase Initialization

- ***First Phase*** 

  stored 프로퍼티에 각각 초기값이 할당 

  이때, 초기화는 SubClass의 property -> SuperClass의 property 

  <img src="https://docs.swift.org/swift-book/_images/twoPhaseInitialization01_2x.png" width="600" align="left">



- ***Second Phase*** 

  새로운 인스턴스의 사용이 준비됐다고 알려주기 전에 저장된 프로퍼티를 커스터마이징

  SuperClass의 property  -> SubClass의 property 

  <img src="https://docs.swift.org/swift-book/_images/twoPhaseInitialization02_2x.png" width="600" align="left">



* 두 단계의 초기화를 위해 Swift Compiler가 하는 **safety-check**
  1. **designated initializer**는, 슈퍼클래스의 이니셜라이저에게 초기화 과정을 위임(delegate)하기 전에, 일단 자기 클래스에서 도입된 모든 프로퍼티가 초기화 되었음을 보장해야 한다.
  2. **designated initializer**는 상속받은 프로퍼티에 값을 할당하기 전에, 슈퍼 클래스의 이니셜라이저에게 초기화 과정을 위임해야 한다.
  3. **Convenience initializers**는, 프로퍼티에 값을 할당하기 전에, 다른 이니셜라이저에게 초기화 과정을 위임해야 한다.
  4. 초기화 ***First Phase*** 가 끝나기 전까지는, 이니셜라이저는 인스턴스 메서드를 호출할 수 없고, 인스턴스 프로퍼티의 값을 읽을 수도 없고, self를 참조할 수도 없다.
  5. 



### Initializer Inheritance and Overriding

>  Swift에서는 슈퍼클래스의 이니셜라이저를 자동으로 상속받지 않는다.

superclass의 초기자를 오버라이드 하기 위해서는 subclass에서 그 초기자에 override 키워드를 붙이고 재정의

```swift
class Vehicle { 
  let hasWheel = true 
  var numberOfWheels = 0 
  var description: String {
    return "\(numberOfWheels) wheel(s)" 
  } // 디폴트 이니셜라이저를 가짐 
} 
  
class Bicycle: Vehicle { 
  override init() { // 디폴트 이니셜라이저를 오버라이드 
    super.init() numberOfWheels = 2 hasWheel = false // error! 상속받은 상수 프로퍼티는 초기화 중에도 바꾸지 못함 
  } 
}
```



### Automatic Initializer Inheritance

> 위에서 언급했듯이 Swift에서는 슈퍼클래스의 이니셜라이저를 서브클래스에서 자동으로 상속받지 않는다. 
>
> 그러나 특정 조건이 만족된다면, 자동으로 상속받아도 안전하다고 판단하여 이니셜라이저를 자동으로 서브클래스에 상속시켜준다. 

* 서브클래스가 **designated initializer**를 정의하지 않으면 자동으로 수퍼클래스의 모든 **designated initializer**를 상속합니다.
* 서브클래스가 슈퍼클래스의 모든 **designated initializer**를 구현한다면 (1번 룰에 의해 상속을 받았든가, 혹은 커스텀 구현을 다 해주든가) -> 자동적으로 슈퍼클래스의 **convenience initializer**들을 상속받는다



#### 참고자료

https://docs.swift.org/swift-book/LanguageGuide/Initialization.html

https://wlaxhrl.tistory.com/19
