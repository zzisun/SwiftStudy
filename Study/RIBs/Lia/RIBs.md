# RIBs

2021.11.30.Tue



## RIBs 란?

: Uber에서 만든 cross-platform 모바일 아키텍쳐 프레임워크



> VIPER 과 비교

![img](https://miro.medium.com/max/1400/1*9gyvu_gEOqMP2cqVx6UUTg.png)

- View Driven Application logic



![img](https://miro.medium.com/max/4000/1*XJ6AbpyQ363r2SSAzwlTqA.png)

<img src="https://miro.medium.com/max/2512/1*l8YqnZScoBKEDci6p3bIiA.png" alt="img" style="zoom:50%;" />

- 이름에서 알 수 있듯이, `Router`,  `Interactor`, `Builder` 가 필수 구성 요소
- 뷰가 옵셔널이기 때문에, 뷰 없이 비즈니스 로직으로만 구현 가능함



RIB는 기능 단위라고 생각하면 됨



<img src="https://github.com/uber/ribs/raw/assets/tutorial_assets/ios/tutorial2-composing-ribs/project-structure.png" alt="Project structure" style="zoom:50%;" />



- 체감한 단점이 너무 명확하다 ^__^
  - 작은 프로젝트에는 적절하지 않다
  - 배우는 데 오래 걸린다























