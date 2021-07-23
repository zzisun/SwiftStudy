## Extension

- 타입을 나눠서 작성 가능합니다
- 하나의 타입으로 동작합니다
- 기존에 작성된 타입을 확장
- 서로 다른 파일에 작성 가능

#### - Extension으로 가능

- 계산 프로퍼티
- 메소드
- 프로토콜
- 서브스크립트
- nested type

#### - Extension으로 불가능

- designated initializer
  - Convenience initializer는 추가 가능합니다.
- 저장 프로퍼티





## POP(Protocol Oriented Programming)

- Protocol Extension에 구현 코드 작성 가능함
- Protocol을 채택해서 Extension으로 구현 코드 작성 가능
- 다중 상속과 비슷한 효과
- 구조체/Enum 사용 시 중복 코드 문제 해결
- 구조체와 Protocol, extension을 활용한 프로그래밍 기법



### Protocol + Unit test

> protocol을 활용한 로그인 서비스 단위 테스트 코드

* protocol로 UserServie를 추상화한다.

```swift
import FirebaseAuth

protocol UserServiceProtocol {
    func login(email: String, password: String, completion: @escaping(Result<Void, Error>) -> Void)
}

final class UserService: UserServiceProtocol {
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
```



* UserServiceProtocol 채택하여 Mock API를 만드는 게 용이하다. 

  : loginResult를 입력받아 테스트 가능하도록 함

```swift
@testable import UnitTestingMVVM

final class MockUserService: UserServiceProtocol {
    
    var loginResult: Result<Void, Error> = .success(())
    
    func login(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(loginResult)
    }
}
```



* Mock API로 viewModel을 테스트한다.

```swift
import XCTest
@testable import UnitTestingMVVM

class LoginViewModelTest: XCTestCase {
    var viewModel: LoginViewModel!
    var mockUserService: MockUserService!
    
    override func setUp() {
        mockUserService = MockUserService()
        viewModel = .init(userService: mockUserService)
    }
    
    func testLoginSuccess() {
        mockUserService.loginResult = .success(())
        viewModel.send(action: .login)
        XCTAssertTrue(viewModel.successPresented)
    }
    
    func testLoginError() {
        mockUserService.loginResult = .failure(NSError(domain: "", code: -1, userInfo: nil))
        viewModel.send(action: .login)
        XCTAssertNotNil(viewModel.error)
    }
}
```

* protocol을 통해 의존성 주입이 가능해져 testablity가 높아진다.

```swift
final class LoginViewModel: ObservableObject {
    
    var emailText = ""
    var passwordText = ""

    private let userService: UserServiceProtocol // <-  private let userService = UserService()
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService // Dependency Injection
    }
    
    func send(action: Action) {
        switch action {
        case .login:
            userService.login(email: emailText, password: passwordText) { result in
                switch result {
                case .success:
                    self.successPresented = true
                case let .failure(error):
                    self.error = error
                }
                
            }
        case .errorConfirm:
            break
        }
    }
}
```



#### 🤔

* protocol extension은 code Readability를 높이고 확장성 높은 코드를 만들 수 있게 한다.

  extension을 통해 해당 프로토콜을 채택한 객체의 수정이 편해지므로 unit test도 용이하게 한다고 볼 수 있을 것 같다.



### Protocol 선택적 요구사항 지정 

> objc 속성이 부여된 프로토콜 중 optional func은 필수로 구현하지 않아도 된다.
>
> 이때 objc 속성의 프로토콜은 objc-C class를 상속받은 클래스에서만 채택할 수 있다.

```swift
import Foundation

@objc protocol Workout {
    func breathe()
    @objc optional func box()
}

class Me: Workout {
    func breathe() {
        print("I can breathe")
    }
}
```


