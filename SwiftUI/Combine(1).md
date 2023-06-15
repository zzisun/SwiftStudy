## PassthroughSubject
- Rx의 PublishSubject
- Observer와 Observable의 역할 동시 수행
- Element없이 빈 상태로 init
- subscribe 이후 방출된 값만 전

## sink
- Rx의 subscribe
- Observable의 알림과 방출에 따라 동작
- Oservable에 Observer를 연결하는 접착제
- Element 방출, 에러, 완료 등 알림을 받기 위해서는 반드시 이 연산자를 Observable에 사용

## removeDuplicates
- RxSwift의 distinctUntilChanged
- 연달아 중복된 값이 방출될 때 해당 값을 무시

## store/AnyCancellable
- RxSwift의 disposeBag
- subscribe가 disposable을 return하기 때문에 처리가 필요
- disposeBag에 담아서 메모리 leak 방지를 위해 처리
- 모든 옵저버들과 방출된 리소스들에 대해서 구독을 해제하는 것
- 수동으로 한다면 disposable을 프로퍼티로 들고있다가 deinit시점에서 dispose해주면

## debounce
- RxSwift의 debounce와 동일
- 여러번 발생하는 이벤트에서 가장 마지막 이벤트를 사용하기 위함
- Throttle은 여러번 발생하는 이벤트를 일정 시간 동안, 한번만 실행 되도록 만드는 개념

## autoconnect
- RxSwift의 refCount와 동일
- 구독을 공유할 때 사용하는 연산자 중 하나
- connectableObservable을 유지하면서 구독자가 있으면 connect / 없으면 자동으로 dispose

## receive
- RxSwift의 observeOn과 동일
- 해당 코드 다음에 오는 subscribe안의 내용을 지정해주는 스케줄러에서 관리

## assign
- RxSwift의 bind(to:)와 동일
- binder옵저버를 사용해서 UI와 Observable을 하나로 묶는 행위

## eraseToAnyPublisher
- RxSwift의 asObservable과 동일
- subject는 Observer와 Observable 둘의 역할을 수행
- 외부에서 observer에 접근하지 못하도록 Observable로만 설정하는 등의 용도

## CombineLatest
- RxSwift의 CombineLatest와 동일
- 마지막 Observable을 합쳐서 방출
