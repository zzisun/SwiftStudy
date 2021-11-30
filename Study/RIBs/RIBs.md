# RIBs 아키텍쳐

## 특징

1. 템플릿화된 코드 및 테스트 작성
2. (강제)프로토콜 지향 프로그래밍
3. 의존성 주입 DI
4. Viewless RIB 통한 비즈니스 로직 정리



## 구성요소

### Router

> 비즈니스 로직 포함

* parent, child 간 연결, detach & attach

### Interator

> Router는 Interactor를 하위 RIBs에 연결

* ViewableRouting 프로토콜에는 attach, detach하기 위한 위치 결정 protocol 
* Presentable 프로토콜에는 현재 RIB에 대한 viewController Protocol 
* Listener 에는 부모 자식 상속관계에 있는곳과 communicate하기 위한 protocol -> 상속 관계 Dependency 관계의 RIB(Interactor) 에서 정의

### Builder

> Builder를 인스턴스화 

* Component, Interactor, Router 생성 Dependency 주입

![Untitled](Ribs%20(RxRibs)%20b05841f29fec41f0be8af9d37d6301a3/Untitled%202.png)

![스크린샷 2021-11-30 오후 6.37.14.png](Ribs%20(RxRibs)%20b05841f29fec41f0be8af9d37d6301a3/%EC%8A%A4%ED%81%AC%EB%A6%B0%EC%83%B7_2021-11-30_%EC%98%A4%ED%9B%84_6.37.14.png)



#### Reference

https://github.com/uber/RIBs

https://github.com/dev4jam/ToDo
