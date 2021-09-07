# Foundation 

> Access essential data types, collections, and operating-system services to define the base layer of functionality for your app.

NS 클래스를 사용하는 데에... 기본적인 기능들인데 왜 runtime에 동작하는 옵씨를 사용하는가~

라는 생각을 하였다,,,

하위계층인 Foundation의 기본적인 데이터, 네트워킹 등의 기능은 생각해보면 runtime에 이루어지기에 옵씨를 사용했군.. 이라는 결론을 내렸다! 

<img width="400" alt="스크린샷 2021-08-02 오후 3 12 19" src="https://user-images.githubusercontent.com/60323625/127812588-e871e125-46b5-4cf4-8ccf-22e4f76cfdfa.png">

위의 Foundation 코드를 보면 import Combine을 맨 첫줄에 확인할 수 있다!

"apple은 Combine의 API를 Foundation 프레임 워크에 통합했기 때문에 Timer, NotificationCenter 및 Core Data와 같은 핵심 프레임 워크는 이미 Combine을 사용한다." 

Combine이 시스템 계층 구조에서 다음과 같이 위치한다. 

![스크린샷 2020-10-03 오후 6.28.53](https://tva1.sinaimg.cn/large/007S8ZIlgy1gjc9x4py0ej30wu0l47dc.jpg)

* `브릿징`



# UIKit

> Construct and manage a graphical, event-driven user interface for your iOS or tvOS app.

* 사용자의 인터페이스를 관리하고, 이벤트를 처리하는게 주 목적인 프레임워크다.

* UIkit에서 주로 처리하는 사용자 이벤트로는 제스처 처리, 애니메이션, 이미지 처리 등이 있다. 

  `UIViewController`, `UIView`등 앞에 `UI`가 붙는 클래스들을 사용하려면 반드시 `UIkit`을 상속해야 한다.

  화면을 구성하기 위해 필수적으로 상속해야하는 프레임워크라고 봐도 무방하다.

* Foundation 과의 관계

  <img width="400" alt="스크린샷 2021-08-02 오후 3 12 19" src="https://media.vlpt.us/post-images/wan088/04203e00-bff7-11e9-aaf8-abce3fc63ae8/image.png">**Cocoa Framework**

  <img width="400" alt="스크린샷 2021-08-02 오후 3 12 19" src="https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FuQS8r%2FbtqNf6Mb2JD%2FR3NfHijcN5Lf608eVlRbF1%2Fimg.png">

  상위 계층인 Cocoa Touch에 속한 UIKit은 다음과 같이 하위 계층인 Foundation을 포함한다.

  <img width="484" alt="스크린샷 2021-08-02 오후 3 38 28" src="https://user-images.githubusercontent.com/60323625/127815235-caa21fdf-a261-4e34-b2d5-31a7ec3a28b2.png">

  그래서 import UIKit만 선언해도  Foundation Framework의 기능들이 동작하였던 것이다~

  

* 프레임워크 계층에 대한 간략한 설명

  `Cocoa Touch` 계층: 하위 계층의 프레임워크를 사용하여 애플리케이션을 직접 구현하는 프레임워크.

  `Media Touch` 계층: 상위 계층인 코코아 터치 계층에 그래픽 관련 서비스나 멀티미디어 관련 서비스를 제공

  `Core Service Touch` 계층: 문자열 처리, 데이터 집합 관리, 네트워크, 주소록 관리, 환경 설정 등 핵심적인 서비스들을 제공.

  `Core OS` 계층: iOS가 운영 체제로서 기능을 하기 위한 핵심적인 영역

  

# Framework vs Library

**Framework**: "사용하는 주체"와 기능의 제어권이 역전 IoC (`Inversion of Control`)
RxSwift와 같이 bind 시켜놓으면 (제어권 부여), 이벤트 일어날 시 처리되는 (제어의 역전) 로직



**Library**: "사용하는 주체"가 기능을 요청하며 사용 (언제 요청 할지, 언제 응답 받을지, 언제 결과 처리할 지 모두 주체가 결정)



`Inversion of Control` 이 핵심적인 차이라고 한다... (추가해놓겠습니다.)

