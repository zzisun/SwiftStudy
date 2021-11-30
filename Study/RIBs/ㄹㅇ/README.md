## RIBs
- view가 아닌 business logic 중심의 구조
- Uber에서 만든 crass-platform 모바일 아키텍쳐 프레임워크
- Router + Interactor + Builder
- "많은" 엔지니어 + nested states(중첩된 상태)의 모바일 앱을 위해 설계

## About

#### Encourage Cross-Platform Collaboration
- OS에 제한되지 않고 단일 아키텍쳐 공유 가능

#### Minimize Global States and Decisions
- global 상태변경은 예측할 수 없는 동작 유발 -> RIBs는 상태를 캡슐화하여 global 상태 문제 방지를 권장

#### Testability and Isolation
- 개별 RIB 클래스에는 별도의 "책임"이 존재 -> 이 책임에는 라우팅, 비즈니스 로직, 뷰 로직, 다른 RIB 클래스 생성이 존재
- 부모 RIB 논리는 자식 RIB 논리와 분리 -> 클래스를 쉽게 테스트 가능

#### Tooling for Developer Productivity
- 코드 생성, 정적 분석 및 runtime integrations에 대한 IDE 툴링을 함께 제공 -> 생산성 향상

#### Open-Closed Principle
- 기존 코드 수정없이 새로운 기능 추가 가능
- 부모 RIB을 거의 변경하지 않고 복잡한 자식 RIB을 attach하거나 build 가능

#### Structured around Business Logic
- 비즈니스 로직에 UI 구조를 엄격하게 반영할 필요가 없음
- 예를들어 애니메이션 및 View 성능을 용이하게 하기 위해서 View 계층 구조는 RIB 계층 구조와 같을 필요 없음
- 단일 기능 RIB이 여러 View에서 동작 가능

#### Explicit Contracts
- Requirements는 complie-time safe contracts로 선언
- 클래스 종속성과 순서 종속성이 충족되지 않으면 클래스는 컴파일되지 않아야 함

## Details

#### Interactor
- Buisness Logic
- Rx subscrioptions를 수행
- 상태 변경 결정을 내림
- 데이터 저장 위치 결정
- 다른 RIB을 자식으로 attach할 위치 결정
- Interactor가 수행하는 모든 작업은 반드시 life cycle에 국한
- Interactor가 활성화 된 경우에만 비즈니스 로직이 실행되도록 설계됨
- Interactor가 비활성화되는 경우는 방지되지만 subscriptions가 계속 발생하여 원치 않는 UI상태 업데이트 발생 가능성 있음
- 그렇기 때문에 life cycle에 국한

#### Router
- Interactor를 listens -> 출력을 하위 RIB에 연결 및 분리로 변환
- Router는 Humble Objects 역할을 하여, 하위 Interactor를 mock하거나 그 존재를 신경쓰지 않고 Interactor 로직 테스트 가능
- Humble Object -> 테스트 가능한 객체를 감싸는 wrapper로, 테스트하기 어려운 객체의 로직을 비용면에서 효율적으로 가져오는 방식

- 상위 interactor와 하위 interactor간에 추가 추상화 계층 생성
- interactor간의 동기 통신이 조금 더 어려워지고, RIB간의 직접 연결 대신 reactive communication 채택 권장

- interactor가 구현할 수 있는 단순하고 반복적인 라우팅 로직 포함
- boilerplate code를 제외하면 interactor를 작게 유지하고 RIB이 제공하는 핵심 비즈니스 로직에 더 집중 가능

#### Builder
- Builder의 책임은 RIB의 각 구성요소 클래스/childeren을 위한 Builder를 인스턴스화 하는 것
- Builder에서 클래스 작성 로직을 분리하면 iOS에서 mockability에 대한 지원이 추가됨
- 나머지 RIB 코드는 DI구현의 세부사항에 영향을 미치지 않음
- Builder는 프로젝트에서 사용된 DI 시스템을 인식해야하는 RIB의 유일한 부분
- 다른 Builder를 구현하면 다른 DI 메커니즘을 사용하여 프로젝트에서 나머지 RIB 코드 재사용 가능

~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
~
 NORMAL   team-1   README.md                                      100%     2:20
"README.md" 2L, 29B
