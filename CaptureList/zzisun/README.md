## **Memory 관리**

### ARC

> Automatic Reference Counting

* compile time에 메모리 할당과 해제 시점이 정해진다.

- run time에 동작하는 GC보다 성능이 좋으며 프로그래머가 메모리할당을 예측하고 사용할 수 있게한다.

- reference type에만 적용 - class instance

- 강한참조 순환 문제를 막기 위해 강한참조 규칙을 알아야한다.

  

strong(default)

weak - optional 타입

unowned - 암시적 추출 옵셔널 타입



### Capture List

> **클로저** 내부에서 참조타입 규칙을 제시하여 self참조 순환문제 해결

##### Strong Capture (default)

```swift
class Order {
    private var menu: String
    
    lazy var description: () -> String = {
        return "\(self.menu), please."
    }
    
    init(menu: String) {
        self.menu = menu
    }
    
    deinit {
        print("\(menu) deinit")
    }
}

var firstOrder: Order? = Order(menu: "Pizza")
print(firstOrder?.description() ?? "No description") // Pizza, please.
firstOrder = nil
```

firstOrder에 nil을 할당했지만 deint이 호출되지 않음. Memory leak 발생.

<img width="450" alt="스크린샷 2021-07-12 오후 2 30 38" src="https://user-images.githubusercontent.com/60323625/125235659-c4c91000-e31d-11eb-8e4d-964a8310092e.png">



참조타입인 클로저는 호출되면 참조카운트 증가 -> 클로저를 프로퍼티로 가지는 인스턴스 firstOrder의 참조카운트도 증가

강한참조 순환 발생!! 	firstOrder 인스턴스가 메모리에서 해제될 수 없다!



##### Weak Capture

```swift
class Order {
    private var menu: String
    
    lazy var description: () -> String = { [weak self] in
        return "\(self!.menu), please."
    }
    
    init(menu: String) {
        self.menu = menu
    }
    
    deinit {
        print("\(menu) deinit")
    }
}

var firstOrder: Order? = Order(menu: "Pizza")
print(firstOrder?.description() ?? "No description") // Pizza, please.
firstOrder = nil // Pizza deinit
```

weak capture는 self를 옵셔널로 만들어 클로저 내부에서 참조한다.

이는  클로저 내부에서 해제된 메모리에 접근하려는 것을 막아 reliability를 높인다.



##### Unowned Capture

```swift
class Order {
    private var menu: String
    
    lazy var description: () -> String = { [unowned self] in
        return "\(self.menu), please."
    }
    
    init(menu: String) {
        self.menu = menu
    }
    
    deinit {
        print("\(menu) deinit")
    }
}

var firstOrder: Order? = Order(menu: "Pizza")
var secondOrder: Order? = Order(menu: "Pasta")

secondOrder?.description = firstOrder?.description ?? {""} // secondOrder에 firstOrder 클로저 할당
print(firstOrder?.description() ?? "No description") // Pizza, please.
firstOrder = nil	// Pizza deinit

print(secondOrder?.description() ?? "No description") // Error 발생
```

미소유 참조는 참조하는 인스턴스가 항상 메모리에 존재할 것이라는 전제로 동작한다.

따라서, 메모리가 해제된 후 unowned capture하게 되면 잘못된 메모리에 접근하게 된다.

```error: Execution was interrupted, reason: signal SIGABRT.```

해제된 firstOrder인스턴스의 프로퍼티에 접근하기에 잘못된 메모리 접근 발생 -> 프로세스 강제 종료 

weak capture를 사용하는게 안전하다!



🤔

##### **weak** vs **unowned** vs **unowned optional** 적절하게 사용하려면?



##### 
