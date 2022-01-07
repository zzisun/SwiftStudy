# VIPER

![image](https://user-images.githubusercontent.com/60323625/148371213-4d2c5b9d-3c0f-43b3-a043-0ce430504021.png)




1. View - 화면
   - 사용자에게 보여지는 View
   - 유저 인터랙션을 받는 역할
   - 이벤트가 발생할 시 Presenter에게 해당 일을 전달
   - Presenter의 요청대로 디스플레이하고 사용자의 입력을 Presenter에게 보냄


2. Presenter - 특정화면 View Model + Usecase 역할
   - Entity로부터 받은 업데이트 이벤트를 실행하지만 데이터를 직접적으로 보내지는 않는다.
   - View 모델의 변경사항을 Interactor에게 알림
   - Interactor로부터 데이터를 가져오고 View로 보내기 위해 데이터를 준비하여 View로 데이터를 디스플레이할 시기를 결정


3. Interacter - NetworkManager 역할

   공용데이터

   - Presenter로부터 받은 모델 변경사항에 따라 Entity에 접속하여 Entity로부터 수신한 데이터를 Presenter에게 전달
   - Use Case에 따라서 Entity 모델 객체를 조작하는 로직을 포함

4. Coordinater - (Router)

   - 인스턴스 생성 및 navigationController를 활용한 viewController 처리
   - Wireframe, Coordinator 라고 불리기도 하며, 화면 간의 탐색을 위한 라우팅을 담당
   - Presenter가 언제 화면을 전환하는지를 담당한다면 Router는 어떻게 화면을 전환하는지를 담당

5. Entity

    순수 모델 객체

   예시

- Model - 코카콜라, 사이다, 커피
- Business Logic - 주문한 음료 개수 x 음료 가격을 받는다.




![image](https://user-images.githubusercontent.com/60323625/148371848-1933ba81-4b71-45f8-befb-8d30b1469b63.png) 

 

### **VIPER 패턴의 장단점**

- 장점
  - 각 도메인의 역할이 명확하게 구분됨 -> testability, 유연성 증가
  - 모듈을 작게 만들고 역할을 분명히 하기에 대규모 프로젝트에 적합
- 단점
  - 많은 파일들이 생성됨 
  - VIPER 아키텍처 유지보수에 대해 세부적인 로직을 추가로 결정해야함
