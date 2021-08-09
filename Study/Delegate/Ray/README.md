## Delegate

## Implemantation of Delegate
> protocol을 활용하여 구현
- 대리, 위임의 의미
- 처리해야할 일 중, 특정 부분을 다른 객체로 '위임'할 때 사용
- Delegate를 통해 위임 받를 객체 설정 필요 ( delegate = self )

## Delegate Pattern
> 수신자, 대리자, 대리자에게 수신자 전달
-  수월한 객체간 상호작용
- 객체를 완전히 상속하지 않기 때문에 가볍게 사용 가능
- 1:1 관계에 적절하며 1:N, N:1의 경우 옵저버 패턴을 사용
- 프로토콜을 활용하여 유연한 코드 작성 가능

```swift
protocol DeliveryInformation: AnyObject {
    func delivery(from info: String)
}

class Receiver: DeliveryInformation {
    let sender = Sender()
    
    init() {
        sender.delegate = self
    }
    
    func delivery(from info: String) {
        print(info)
    }
}

class Sender {
    weak var delegate: DeliveryInformation?
    let information = "Hello World"
    
    func transfer() {
        delegate?.delivery(from: information)
    }
}
```

## Delegate Proxy
> Delegate를 사용하는 부분을 RxSwiftf로 표현할 수 있게하는 것
- Rxswift의 DelegateProxy.swift와 DelegateProxyType.swift 두 파일을 사용
- delegate를 사용하는 프레임워크와 RxSwift사이의 다리역할

#### Delegate Proxy 구현
```swift
import Foundation
import RxSwift
import RxCocoa
import UIKit

class RxUITextFieldDelegateProxy: DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate{
    static func registerKnownImplementations() {
        self.register { (textField) -> RxUITextFieldDelegateProxy in
            RxUITextFieldDelegateProxy(parentObject: textField, delegateProxy: self)
        }
    }

    static func currentDelegate(for object: UITextField) -> UITextFieldDelegate? {
        return object.delegate
    }

    static func setCurrentDelegate(_ delegate: UITextFieldDelegate?, to object: UITextField) {
        object.delegate = delegate
    }
}
```
#### 이벤트 등록
```swift
extension Reactive where Base: UITextField {
    var delegate : DelegateProxy<UITextField, UITextFieldDelegate> {
        return RxUITextFieldDelegateProxy.proxy(for: self.base)
    }

    var myTextFieldDelegate: Observable<Bool> {
        return
            delegate.methodInvoked(#selector(UITextFieldDelegate.textFieldShouldBeginEditing(_:)))
                .map { _ in return true }
    }
}
```

#### Delegate Proxy 사용
```swift
import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class ViewController: UIViewController {
    @IBOutlet myTextFiled: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        myTextFiled.rx.myTextFieldDelegate.asObservable()
            .bind(onNext: { _ in })
            .disposed(by: rx.disposeBag)

    }
}
```
