## SwiftUI

#### @Published

- SwiftUI에서 가장 유용한 property wrappers 중 하나
- @Published로 표시된 property를 가진 객체가 변경될 때마다, 해당 객체를 사용하는 모든 view 변경
- 옵트인(opt-in: 수신자의 허락이 있을 때만 변경 값을 발송) 방식으로 동작

#### @Binding

- 하나의 값이 실제로 다른 곳에서 오고, 두 군데에서 공유되어야 한다고 선언하는 것
- @Binding 프로퍼티를 가지고 있지 않은 외부 뷰에서 값을 받아서, @Binding 프로퍼티를 가지고 있는 객체와 공유하여 사용한다는 의미

#### @State

- SwiftUI는 State로 선언한 모든 프로퍼티의 스토리지를 관리
- State 값이 변경되면 view가 appearance를 invalidate하고 body를 다시 계산
- state인스턴스는 value자체가 아니고, 값을 읽고 변경하는 수단
- state의 기본 값에 접근하려면 value 프로퍼티를 사용
- view의 body에서만 state 프로퍼티에 접근할 것
- view의 client에서 state에 접근하지 못하도록, state 프로퍼티를 private으로 선언
- 특정 view에서만 사용되는 프로퍼티
- @State 속성을 붙이면, SwiftUI가 자동으로 변경사항을 관찰하고 view를 업데이트

#### @ObservedObject

- 여러 프로퍼티나 메소드가 있거나, 여러 view에서 공유할 수 있는 커스텀 타입이 있는 경우
- String이나 Integer같은 간단한 로컬 프로퍼티 대신, 외부 참조 타입을 사용
- @ObservedObject와 함께 사용하는 타입은 ObservableObject 프로토콜을 채택해야 함
- observed object 데이터의 변경을 view에 알리는 대표적인 방법 @Published 프로퍼티 래퍼 사용

#### @EnvironmentObject

- "It’s shared data that every view can read if they want to."
- 바인딩 가능한 객체가 변경될 때마다 현재 view를 invalidate하기 위해 상위 view에서 제공한 Binding가능한 객체를 사용하는 dynamic view property
- 반드시 environmentObject(_ :) 메소드를 호출하여 상위 뷰에서 모델 객체를 설정해야 함
- @EnvironmentObject로 선언하면 앱의 어느 곳에서나 공유할 수 있는 데이터가 됨
- 모델이 변경되면 EnvironmentObject가 바인딩되고 있는 모든 view는 자동으로 업데이트
