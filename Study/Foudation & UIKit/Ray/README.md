## Foundation & UIKit

### Cocoa Touch
>  iOS 개발 환경을 구축하기 위한 최상위 프레임워크
- UIKit, Foudation을 포함한 대부분의 클래스들이 모두 코코아 터치 프레임워크에 속함

### UIKit
> 사용자의 인터페이스를 관리하고, 이벤트를 처리하는 게 주요한 목적
- 제스처, 애니메이션, 이미지, 텍스트 처리 등
- UIViewController, UIView 등 UI가 붙는 클래스를 사용하기 위해서 필요
- 즉, 화면을 구성하기 위해 반드시 필요

### Foudation
> 가장 기본적인 원시 데이터 타입이 Foundation에 포함
#### 기본
- 원시데이터: Number, Data, String
- Collection: Array, Dictionary, Set
- Date & Time
- Unit and Measurement
- Data Foramatting
- Filter & Sorting

#### 앱 지원
- Resources: 에셋과 번들 데이터에 접근 지원
- Notification: 정보를 퍼뜨리거나 받아드리는 기능 지원
- Extension: 확장 애플리케이션과 상호 지원
- Error & Exception: API와의 상호작용에서 발생할 수 있는 문제 상황에 대처할 수 있는 기능 지원

#### 파일 및 데이터 관리
- File System: 파일 또는 폴더를 생성하고 읽고 쓰는 기능 관리
- Archives and Serialization: 속성 목록, JSON, 바이너리 파일들을 객체로 변환 또는 반대 작업 관리
- iCloud: 사용자의 iCloud 계정을 이용해 데이터를 동기화하는 작업 관리

#### 네트워킹
- URL Loading System: 표준 인터넷 프로토콜을 통해 URL과 상호작용하고 서버와 통신하는 작업
- Bonjour: 로컬 네트워크를 위한 작업

### 계층구조
> UIKit(Cocoa Touch계층)은 Foudation(Core Service)을 상속하였기 때문에, UIKit만 사용해도 Foudation 기능사용 가능
- Cocoa Touch: UIKit, GameKit, MapKit
- Media: Core Graphics, Core Text, Core Audio, Core Animation, AVFoundation
- Core Service: Foudation, Core Foudation, Core Location, Core Motion, Core Animation, Core Data
- Core OS: 커널, 파일시스템, 네트워크, 보안, 전원 관리, 디바이스 드라이버
