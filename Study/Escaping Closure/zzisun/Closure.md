# Escaping Closure



## closure란?

> ~~사용자의 코드 내에서 구분된 코드 블럭~~, **참조타입**이다.
>
> 함수도 closure의 한 형태로, 이름이 있는 클로저이다.



```swift
let hello:((_ name:String)->String) = { name in return "\(name) hello"}
hello("zzisun") // zzisun hello
```

클로저는 매개변수로 전달받은 "zzisun" 를 캡쳐해서 저장해 놓는다.



```swift
class Person {
    var name:String
    
    init(name:String) {
        self.name = name
    }
}

let person = Person(name: "zzisun")
let hello:((_ person:Person)->String) = { person in return "\(person.name) hello"}
hello(person) // zzisun hello
```

참조타입이 들어오면 클로져도 참조타입으로 값을 저장한다.

즉, 매개변수로 들어온 **타입에 따라서 값을 캡쳐**하게 된다.



이러한 원리로 탈출 클로져는 참조 타입의 값을 캡쳐해놓고 있다가 함수가 끝난 뒤에도 값을 전달할 수 있다!

## escaping closure란?

> **클로저가 함수의 매개변수로 전달되지만 함수 밖에서 실행되는 것(함수가 반환된 후 실행되는 것)**을 **Escape**한다고 하며, 
>
> 이러한 경우 매개변수의 타입 앞에 **@escaping**이라는 키워드를 명시해야한다. 



```swift
var completionHandlers: [() -> ()] = []

func WithEscapingClosure(completionHandler: @escaping () -> ()) {
    completionHandlers.append(completionHandler)
}

func WithoutscapingClosure(closure: () -> ()) {
    closure()
}

class Apple {
    var price = 1000
    func doSomething() {
        WithEscapingClosure { self.price = 1000 } // 명시적으로 self를 적어줘야 한다.
        WithoutscapingClosure { price = 2000 }
    }
}

let myApple = Apple()
myApple.doSomething()
print(myApple.price) // 2000

completionHandlers.first?() // completionHandlers의 closure 실행
print(myApple.price) // 1000
```

completionHandlers의 escaping closure을 사용하면 사과를 합리적인 가격에 살 수 있는 예제입니다..ㅎㅎ



탈출조건

1. 클로저가 함수 외부로 전달되어 외부에서 사용이 가능한 경우
2. 클로저가 외부 변수에 저장되는 경우

위와 같은 조건에서는 @escaping 키워드를 사용해서 탈출 클로저임을 명시해야한다.



다음과 같은 경우에 자주 사용된다.

- **비동기**로 실행되는 경우

- **completionHandler**(완료에 따른 처리)로 사용되는 클로저의 경우

  : 네트워크 요청 작업을 비동기적으로 처리하고, 작업이 끝난 후 동작하는 것을 Completion Handler에 명령하는 경우



### 참고자료

https://learnappmaking.com/escaping-closures-swift/

https://hcn1519.github.io/articles/2017-09/swift_escaping_closure
