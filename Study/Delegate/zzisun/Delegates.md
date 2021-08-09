# Delegate Pattern



### Delegate란?

* Asynchronous Programming Mechanisms 중 하나!

<img width="500" align=left alt="스크린샷 2021-08-09 오후 1 12 22" src="https://user-images.githubusercontent.com/60323625/128659777-0c5e0358-0ae7-4b1d-8071-0c74e83bb7e5.png">



"delegate를 그대로 해석해서 위임자, 다시 말해 대신해서 일을 처리해준다" 라고 알고 있었다.

 그러나

[article](https://developer.apple.com/documentation/swift/cocoa_design_patterns/using_delegates_to_customize_object_behavior/)과 [군옥수수수](https://baked-corn.tistory.com/23)의 블로그 글을 보며,,

>  You use delegates to interact with Cocoa objects that inform you of events in an app.

> *델리게이트는 어떤 객체가 해야 하는 일을 **부분적**으로*
> *확장해서 대신 처리를 한다.*



Delegate를 구현한다고 해서 어떤 객체의 일을 <u>완전히 처리해주지는 않는다</u>는 것을 알게 되었다. 



### 구현방법

<img width="424" align=left alt="스크린샷 2021-08-09 오후 2 27 34" src="https://user-images.githubusercontent.com/60323625/128663557-339c14d7-14c8-443f-ab67-f58ed2e40d15.png">

`Sender` 에서 일어나는 이벤트에 관한 코드를  `Receiver`에서 작성한다. 

즉, `Sender`의 일을 `Receiver`에게 위임하며 이때 할일들은 `protocol`을 통해 전달된다.


`protocol` : 해야할 일의 목록

`sender` : 일을 시키는 객체

`receiver` : 일을 하는 객체



1. 요구사항에 해당하는 protocol 디자인

2. `Receiver`는 해당 Delegation Protocol을 채택하고 메소드를 구현

3. `Receiver`가 `Sender`에서 일어난 이벤트의 관련된 일을 할 것이라고 명시

   

### 예제를 통해 알아보자

<img width="300" align=left alt="스크린샷 2021-08-09 오후 2 27 34" src="https://user-images.githubusercontent.com/60323625/128667381-165392d3-1e64-4d54-869f-408de3afb215.gif">



1. 요구사항에 해당하는 protocol 디자인

```swift
// Sender
public protocol QuestionViewControllerDelegate: AnyObject {
  func questionViewController(_ viewController: QuestionViewController,
                              didCancel questionGroup: QuestionGroup,
                              at questionIndex: Int)
  
  func questionViewController(_ viewController: QuestionViewController,
                              didComplete questionGroup: QuestionGroup)
}

public class QuestionViewController: UIViewController {

  // MARK: - Instance Properties
  weak var delegate: QuestionViewControllerDelegate?
```



2. `Receiver`는 해당 Delegation Protocol을 채택하고 메소드를 구현

3.`Receiver`가 `Sender`에서 일어난 이벤트의 관련된 일을 할 것이라고 명시

```swift
// Receiver
extension SelectQuestionGroupViewController: QuestionViewControllerDelegate {
  public override func prepare(for segue: UIStoryboardSegue, sender: Any?){
    guard let viewController = segue.destination as? QuestionViewController else { return }
    viewController.delegate = self
  }
  
  public func questionViewController(_ viewController: QuestionViewController,
                                     didCancel questionGroup: QuestionGroup,
                                     at questionIndex: Int) {
    navigationController?.popToViewController(self, animated: true)
  }
  
  public func questionViewController(_ viewController: QuestionViewController,
                                     didComplete questionGroup: QuestionGroup) {
    navigationController?.popToViewController(self, animated: true)
  }
}
```



### 마무리하며

> Delegate를 통해 다른 개체를 대신하거나 함께 조정하는 개체를 정의할 수 있다.
>
> App delegate에서 새로운 notification이 도착하면 수행할 작업을 정의하지만 이 코드가 언제 실행될지 또는 몇 번 실행될지 알 수 없다.

이런 점이 본질적으로 비동기적으로 동작하는 UI 이벤트에서 delegate가 자주 사용되는 이유이다.



**주의할 점⚠️**

 Delegate 패턴은 순환 참조에 의한 메모리 leak에 주의해야 한다.

 델리게이트 선언 시 사용되는 protocol을 AnyObject(~~class~~) 타입으로 제한하고 (클래스 타입만 채택할 수 있도록), 

 델리게이트 프로퍼티를 선언하며 weak을 지정해야 한다.



**출처**

[iOS Delegate 패턴에 대해서 알아보기](https://magi82.github.io/ios-delegate/)

[델리게이트-패턴-사용-시-순환참조에-의한-메모리릭](https://goodmorningcody.wordpress.com/2016/11/24/)

[multicast delegate](https://www.vadimbulavin.com/multicast-delegate/)
