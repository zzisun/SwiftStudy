## NSObject

#### Root Class
> Objective-C 클래스 계층 구조의 Root Class
- 하위클래스에서 런타임 시스템에 대한 기본 인터페이스와 Objective-C 객체로 작동하는 기능 상속
- Cocoa / CocoaTouch 애플리케이션의 모든 객체는 궁극적으로 NSObject로 부터 상속됨
- NSObject는 프로그래밍 인터페이스를 제공하는 NSObject 프로토콜을 채택
- Root class는 런타임 시스템에 대한 인터페이스 역할

#### Conform NSObject
> NSObject Protocol을 채택하는 객체는 일급객체로 취급
- Class와 상속계층내의 클래스 위치
- 프로토콜의 채택
- 특정 메세지에 응답할 수 있는 능력
```
- Cocoa의 최상위 Root class인 NSObject는 NSObjectProtocol을 채택
- NSObject를 상속받는 모든 객체는 위 기능들을 갖게 됨
```

#### Objective-C Runtime
> Swift에서 NSObject를 상속받으면, Objective-C와 호환가능하며 Objective-C Runtime에서 동작
- 메서드, 변수, 클래스간의 링크가 앱이 실행될 때까지 가능한 마지막 순간으로 연기 -> Greate flexibility
- Swift는 Compile-Oriented Language인만큼  safety는 좋지만 flexibility가 떨어짐
- 사용자가 만드는 데이터를 모를 때, runtime에서 class을 만들 수 있음

[Objective-C Runtime](https://medium.com/@neroxiao/objective-c-runtime-notes-f7e36db4daf1)
[Objective-C Runtime2](https://www.slideshare.net/old2new/objectivec-runtime-37749350)

