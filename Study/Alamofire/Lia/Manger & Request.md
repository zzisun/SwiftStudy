# Alamofire 핵심 클래스 이해하기

> 2022.03.08. 화



## 1. Manager

싱글톤 매니저 - 탑레벨 Alamofire request 메서드를 사용하기 위함



> 변수

- delegate: ***SessionDelegate***   // init에 명시
- queue (serial queue)
- session: NSURLSession  (configuration 필요)   // init에 명시
- startRequestsImmediately: Bool



> 메서드

- request(URLRequest: URLRequestConvertible) → **`Request`**



> 내부 클래스 :  ***SessionDelegate***

- 상속하는 객체
  - NSObject
  - NSURLSessionDelegate
  - NSURLSessionTaskDelegate
  - NSURLSessionDataDelegate
  - NSURLSessionDownloadDelegate
- 변수 : session~~ / task~~
- 메서드 : URLSession



> extension

- upload(uploadable: Uploadable) ->  **`Request`**
- download(downloadable: Downloadable, destination: (NSURL, NSHTTPURLResponse) -> (NSURL)) ->  **`Request`**



> 용도

```swift
public func request(URLRequest: URLRequestConvertible) -> Request {
    return Manager.sharedInstance.request(URLRequest.URLRequest)
}

public func upload(method: Method, URLString: URLStringConvertible, file: NSURL) -> Request {
    return Manager.sharedInstance.upload(URLRequest(method, URLString), file: file)
}

public func download(method: Method, URLString: URLStringConvertible, destination: Request.DownloadFileDestination) -> Request {
    return Manager.sharedInstance.download(URLRequest(method, URLString), destination: destination)
}
```

- 이런 식으로 매니저를 통해 자주 쓸만한 함수를 간편하게 호출함





## 2. Request

<img src="/Users/gimjigyeong/Library/Application Support/typora-user-images/image-20220315195729376.png" alt="image-20220315195729376" style="zoom:30%;" />

> 변수

- delegate: ***TaskDelegate***
- task: NSURLSessionTask    //  init에 명시    (delegate.task)
- session: NSURLSession    //  init에 명시
- request: NSURLRequest    (task.originalRequest)
- response: NSHTTPURLResponse?    (task.response)
- progress: NSProgress?      (delegate.progress)



> 메서드

- authenticate(#user: String, password: String) -> **Self**
- progress(closure: ((Int64, Int64, Int64) -> Void)? = **nil**) -> **Self**
- responseDataSerializer() -> Serializer
- response(completionHandler: (NSURLRequest, NSHTTPURLResponse?, AnyObject?, NSError?) -> Void) -> **Self**
- suspend()
- resume()
- cancel()



> 내부 클래스 :  ***TaskDelegate***

- 상속하는 객체
  - NSObject
  - NSURLSessionTaskDelegate
- 변수
  - task: NSURLSessionTask
  - queue: dispatch_queue_t
  - progress: NSProgress
  - data: NSData?
  - error: NSError?
  - credential: NSURLCredential?
  - task~~ (closure)

- 메서드 : URLSession



> 내부 클래스2 : DataTaskDelegate

- 상속하는 객체
  - ***TaskDelegate***
  - NSURLSessionDataDelegate
- 변수
  - dataTask: NSURLSessionDataTask!
  - mutableData: NSMutableData
  - data: NSData?
  - expectedContentLength: Int64?
  - dataTask~~ (closure)
- 메서드 : URLSession



> extension

- Validation
- Download
  - **class** DownloadTaskDelegate: TaskDelegate, NSURLSessionDownloadDelegate
    - 메서드 : URLSession
- Printable
- Response Serializers
- JSON
- Property List


