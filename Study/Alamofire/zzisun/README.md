# Manager

> 기본 'NSURLSession'뿐만 아니라 'Request' 객체를 생성하고 관리하는 역할을 담당합니다.

![img](https://koenig-media.raywenderlich.com/uploads/2017/06/url_session_diagram_1.png)

Request 처리 과정

1. create URL
2. create URLSession
3. Give URLSession a task
4. Start a task



##### DataTask

* URLSessionDataTask

  > Response in memory
  > Not supported in background sessions

* URLSessionUploadTask

  > Easier to provide request body 

* URLSessionDownloadTask

  > Response written to file on disk 

  ![img](https://koenig-media.raywenderlich.com/uploads/2017/06/url_session_diagram_2.png)

### properties

```````````swift
		public class var sharedInstance: Manager

		private let delegate: SessionDelegate

    private let queue = dispatch_queue_create(nil, DISPATCH_QUEUE_SERIAL)

    /// The underlying session.
    public let session: NSURLSession

    /// Whether to start requests immediately after being constructed. `true` by default.
    public var startRequestsImmediately: Bool = true
```````````

1. sharedInstance: 최상위 Alamofire 요청 메서드에서 사용되며 모든 임시 요청에 직접 사용하기에 적합한 'Manager'의 공유 인스턴스
2. delegate
3. queue
4. session
5. startRequestsImmediately



### points

1. **public** **func** request(URLRequest: URLRequestConvertible) -> Request

2. SessionDelegate

   > A protocol that defines methods that URL session instances call on their delegates to handle session-level events, like session life cycle changes.

   1. **NSURLSessionDelegate**

      > 세션 수준 이벤트를 처리

   2. **NSURLSessionTaskDelegate**

      > 모든 작업 유형에 공통된 작업 수준 이벤트를 처리

   3. **NSURLSessionDataDelegate**

      > 데이터 및 업로드 작업과 관련된 작업 수준 이벤트를 처리

   4. **NSURLSessionDownloadDelegate**

      > 다운로드 작업과 관련된 작업 수준 이벤트를 처리

   5. **NSObject** -> Object-C runtime

      > 스트림 작업과 관련된 작업 수준 이벤트를 처리



#### Delegate

URLSession의 데이터 반환 방법 2가지

  		1. completion handler
  		2. delegate method call
