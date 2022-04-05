# Upload/Download



> 2022.03.22. 화



Manager의 extension 부분에 정의됨

- 나중에 싱글톤을 호출해서 더 편하게 쓰기 위함



## 1. Upload



> 종류

1. Data
2. File
3. Stream

- 연관값을 사용함



#### 연관값과 업로드의 관계성 탐구하기

```swift
private enum Uploadable {
    case Data(NSURLRequest, NSData)
    case File(NSURLRequest, NSURL)
    case Stream(NSURLRequest, NSInputStream)
}
```

- case 옆에 튜플 형태로 적는다
- 해당 케이스에 연관된 추가 값을 줄 수 있다
- 이를 이용해서 조건문의 조건에 쓰일 수도 있는 등 활용의 여지가 있다

```swift
// private func upload(uploadable: Uploadable) -> Request

switch uploadable {
        case .Data(let request, let data):
            uploadTask = session.uploadTaskWithRequest(request, fromData: data)
        case .File(let request, let fileURL):
            uploadTask = session.uploadTaskWithRequest(request, fromFile: fileURL)
        case .Stream(let request, var stream):
            uploadTask = session.uploadTaskWithStreamedRequest(request)
        }
```

- 여기에서는 굳이 URLRequest를 따로 인자로 넘겨주지 않고, 열거형의 연관값으로 함께 묶어서 쓰려고 한 것 같다
- 그리고 데이터/파일/스트림 각 타입에 맞게 업로드해야할 정보를 연관값으로 묶어서 전달한다

```swift
// private func upload(uploadable: Uploadable) -> Request

        let request = Request(session: session, task: uploadTask)
        if stream != nil {
            request.delegate.taskNeedNewBodyStream = { _, _ in
                return stream
            }
        }
        delegate[request.delegate.task] = request.delegate

        if startRequestsImmediately {
            request.resume()
        }

        return request
}
```

- 연관값으로 넘겨준 request와 정보(데이터/파일/스트림)으로 `uploadTask` 를 생성하고
- 이  `uploadTask` 와 세션을 통해 `request` 를 생성하여 별 일 없으면 리턴한다
  - 기본 `URLSession` 은  `uploadTaskWithRequest` 업로드를 지원해주는데, request와 업로드할 정보를 매개변수를 받는다
- 이때, 스트림이 존재하면, 스트림을 반환한다



#### 왜 upload 함수가 여러 개일까?

```swift
    public func upload(URLRequest: URLRequestConvertible, file: NSURL) -> Request {
        return upload(.File(URLRequest.URLRequest, file))
    }

    public func upload(URLRequest: URLRequestConvertible, data: NSData) -> Request {
        return upload(.Data(URLRequest.URLRequest, data))
    }

    public func upload(URLRequest: URLRequestConvertible, stream: NSInputStream) -> Request {
        return upload(.Stream(URLRequest.URLRequest, stream))
    }
```

- 그냥 바로 `func upload(uploadable: Uploadable) → Request` 를 써도 되지 않나? 생각이 들었지만
- 정보(데이터/파일/스트림) 업로드라는 같은 기능을 하는 함수를 저렇게 `Uploadable` 을 통해 추상화하고
- 구체적인 함수는 public으로 open 한 게 아닌가.. 생각이 들었다



#### Stream이란 무엇일까?

```swift
var stream: NSInputStream?

if stream != nil {
            request.delegate.taskNeedNewBodyStream = { _, _ in
                return stream
            }
        }
```

- 스트림 : 시간이 지남에 따라 사용할 수 있게 되는 일련의 데이터 요소로, 영상, 음성, 패킷 등의 작은 조각들이 하나의 줄기를 이루며 전송된다
- 인스턴스화를 할 수 없는 추상 클래스로, 무조건 스트림을 상속받는 `input/outputStream` 서브 클래스를 써야한다
- `open` `close` 로 스트림을 `run loop` 에 올려서 스트림을 읽고/쓰고/클라이언트가 직접 쓸 수 있게 한다



> 음..이게 왜 이렇게 쓰이나 고민해봤다

- 파일이나 데이터는 그냥 리퀘스트와 함께 업로드 할 수 있을 것 같지만
- 스트림의 경우에는, 즉시 즉시 데이터를 주고 받으며 업로드해야하기에 존재하는 즉시 스트림을 리턴하는 게 아닐까.. 생각했다!



> 궁금한 점

- 왜 Request의 extension에도 업로드/다운로드 관련 함수와 클래스가 있는 걸까....
- 심지어 
```swift
public class func suggestedDownloadDestination(directory: NSSearchPathDirectory = .DocumentDirectory, domain: NSSearchPathDomainMask = .UserDomainMask) -> DownloadFileDestination
```
얘는 쓰이지도 않음







## 2. Download



```swift
private enum Downloadable {
        case Request(NSURLRequest)
        case ResumeData(NSData)
    }
```

- 마찬가지로 열거형과 연관값을 사용하고 있음



```swift
    private func download(downloadable: Downloadable, destination: (NSURL, NSHTTPURLResponse) -> (NSURL)) -> Request {
        var downloadTask: NSURLSessionDownloadTask!

        switch downloadable {
        case .Request(let request):
            downloadTask = session.downloadTaskWithRequest(request)
        case .ResumeData(let resumeData):
            downloadTask = session.downloadTaskWithResumeData(resumeData)
        }
```

- 마찬가지로 추상적으로 숨겨둔 download(downloadable) 함수를 정의한다
- request와 resumeData로 `downloadTask` 를 생성한다



```swift
let request = Request(session: session, task: downloadTask)
        if let downloadDelegate = request.delegate as? Request.DownloadTaskDelegate {
            downloadDelegate.downloadTaskDidFinishDownloadingToURL = { (session, downloadTask, URL) in
                return destination(URL, downloadTask.response as NSHTTPURLResponse)
            }
        }
        delegate[request.delegate.task] = request.delegate

        if startRequestsImmediately {
            request.resume()
        }

        return request
```

- 이건 뭘까 싶다



> public func download

```swift
    public func download(URLRequest: URLRequestConvertible, destination: (NSURL, NSHTTPURLResponse) -> (NSURL)) -> Request {
        return download(.Request(URLRequest.URLRequest), destination: destination)
    }

    public func download(resumeData: NSData, destination: Request.DownloadFileDestination) -> Request {
        return download(.ResumeData(resumeData), destination: destination)
    }
```

















