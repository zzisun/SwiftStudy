# Alamofire Source Code



> HTTP method 정의

```swift
public enum Method: String {
    case OPTIONS = "OPTIONS"
    case GET = "GET"
    case HEAD = "HEAD"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
    case TRACE = "TRACE"
    case CONNECT = "CONNECT"
}
```

- GET, POST, PUT, DELETE 만 알고 나머지는 전혀 몰랐다
- [HTTP method 정리 블로그](https://javaplant.tistory.com/18) 참고
- <img src="https://blog.kakaocdn.net/dn/Nd2N6/btqzps4ExqN/eQ08LDODFnkDPKivu56vkk/img.jpg" alt="img" style="zoom:70%;" /> 



## 2. Parameter Encoding

 A query string to be set as or appended to any existing URL query for `GET`, `HEAD`, and `DELETE` requests, or set as the body for requests with any other HTTP method. The `Content-Type` HTTP header field of an encoded request with HTTP body is set to `application/x-www-form-urlencoded`. Since there is no published specification for how to encode collection types, the convention of appending `[]` to the key for array values (`foo[]=1&foo[]=2`), and appending the key surrounded by square brackets for nested dictionary values (`foo[bar]=baz`).

'GET', 'HEAD' 및 'DELETE' 요청에 대해 기존 URL 쿼리로 설정하거나 추가할 쿼리 문자열 또는 다른 HTTP 메서드를 사용한 요청의 body로 설정할 쿼리 문자열입니다. HTTP body로 인코딩된 요청의 'Content-Type' HTTP 헤더 필드가 'application/x-ww-form-urlencoded'로 설정됩니다. 컬렉션 유형을 인코딩하는 방법에 대한 공개된 규격이 없기 때문에 배열 값의 키('foo[]=1&foo[]=2`)에 '[]'을 추가하고 중첩된 사전 값의 경우 대괄호로 둘러싸인 키('foo[bar]=baz')를 추가하는 규칙이 있다.



### Encode 함수

: URL request 생성 함수



> URLRequest 란

<img src="/Users/gimjigyeong/Library/Application Support/typora-user-images/image-20220111175644158.png" alt="image-20220111175644158" style="zoom:30%;" />

- 로드할 url과 로드 정책을 캡슐화한다 → http method
- http request 를 위해 http method와 http header도 포함한다



> 파라미터 - URLRequestConvertible

```swift
// MARK: - URLRequestConvertible

/**
    Types adopting the `URLRequestConvertible` protocol can be used to construct URL requests.
*/
public protocol URLRequestConvertible {
    /// The URL request.
    var URLRequest: NSURLRequest { get }
}

extension NSURLRequest: URLRequestConvertible {
    public var URLRequest: NSURLRequest {
        return self
    }
}
```

- 매개변수를 적용하기 위한 Request



```swift
var mutableURLRequest: NSMutableURLRequest! = URLRequest.URLRequest.mutableCopy() as NSMutableURLRequest
var error: NSError? = nil
```

- 리턴할 변수를, 새로운 인스턴스로 만든다



> queryComponents - ParameterEncoding 내부 함수

- key, value(AnyObject) 를 매개변수로 받아서, 중첩된 상태를 포함해서 [String, String] dictionary로 변환하는 함수



> encodesParametersInURL

```swift
 func encodesParametersInURL(method: Method) -> Bool {
                switch method {
                case .GET, .HEAD, .DELETE:
                    return true
                default:
                    return false
                }
            }
```

- query string은 대체로 GET 에 쓰인다
- POST에 작성하면 안 된다는 규칙은 없지만, 파라미터 중복 등의 문제로 지양한다고 한다
- 왜...???
- Query string  vs  Path value?? 의 문제일까?



> .URL 내부 코드

```swift
let method = Method.fromRaw(mutableURLRequest.HTTPMethod)
if method != nil && encodesParametersInURL(method!) {
    let URLComponents = NSURLComponents(URL: mutableURLRequest.URL!, resolvingAgainstBaseURL: false)
    URLComponents.query = (URLComponents.query != nil ? URLComponents.query! + "&" : "") + query(parameters!)
    mutableURLRequest.URL = URLComponents.URL
} else {
    if mutableURLRequest.valueForHTTPHeaderField("Content-Type") == nil {
        mutableURLRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    }
    mutableURLRequest.HTTPBody = (CFURLCreateStringByAddingPercentEscapes(nil, 
                                                                          query(parameters!) as NSString, 
                                                                          nil, 
                                                                          nil, 
                                                                          CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)) as NSString).dataUsingEncoding(NSUTF8StringEncoding, 
                                                                          allowLossyConversion: false)
```

- url param encoding의 경우, 파라미터로 전달한 인자들로, URLComponent를 통해 새로 url 을 만듦
- 



요청 스트림 어떻게 처리하는지?

요청, 응답 이런 것, async, sync 차이점들

**흐름 중심**으로 봐도, 네트워크니까 괜찮지 않을까? 동의합니다!!!!

**개념** 다시 잡는 방향..

??? ??? ??? ??? ??? ???







## 1. Chainable Request / Response methods



#### What I learned

> how to make chaining method?

- [method chaining](https://abhimuralidharan.medium.com/chaining-methods-in-swift-not-optional-chaining-3007d1714985)

- ```swift
  class APICaller {
      var url:URL?
      var method = HTTPMethods.get
      var params:[String:String]?
      enum HTTPMethods: String {
          case get = "GET"
          case post = "POST"
          case put = "PUT"
          case patch = "PATCH"
          case delete = "DELETE"
      }
      
      func urlString(_ urlString: String?) -> APICaller {
          if let urlString = urlString {
              self.url = URL(string: urlString)
          }
          return self
      }
      
      func method(_ method:HTTPMethods) -> APICaller {
          self.method = method
          return self
      }
      
      func parameters(_ params:[String:String]) -> APICaller {
          self.params = params
          return self
      }
      
      func response(response:@escaping([String:AnyObject]) -> Void) {
          // create URLRequest with the http method, url, parameters etc 
          // and do the api call using URLSession method.. say use DataTask.
          let resultDictionary = ["result":["Result values1","Result values2","Result values3","Result values4"]]
          // let resultDictionary be the output of the API call made. 
          // Now, call the completion closure and pass the value .
          DispatchQueue.main.async {
              response(resultDictionary as [String:AnyObject])
          }
      }
  }
  ```
  
- ```swift
  let params = ["key1":"value1", "key2":"value2"]
  
  APICaller()
    .urlString(“www.google.com")
    .method(.post)
    .parameters(params)
    .response { (resultDict) in
        print(resultDict[“result”]!)
     }
  
  // prints the following in console.
  (
  "Result values1",
  "Result values2",
  "Result values3",
  "Result values4"
  )
  ```
  
- `return self` 를 통해 chaining 을 가능케 하고, closure + return self 를 통해 익숙한 형태의 chaining을 만들 수 있다.



> computed property 의 속성

- **Computed Property**는 메모리 공간을 가지지 않는다
  - 다른 속성에 저장된 값을 읽어서 필요한 계산을 실행한 다음 **return** 함
  - 연산 프로퍼티에 값을 할당하는 것은 속성으로 전달된 값을 다른 속성에 저장하는 것
- 이런 특징 때문에 속성에 접근할 때마다 다른 값이 반환될 수 있음
  - 연산 프로퍼티는 let이 아닌 **var**로 선언해야함 
  - 저장 속성은 클래스, 구조체에만 추가할 수 있지만 연산 프로퍼티는 **클래스, 구조체 뿐만 아니라 열거형에도 추가**할 수 있음
- [출처](https://onelife2live.tistory.com/17)



> URLSessionTask 개념

- URLsession으로 다운로드나 resource 관련한 작업들을 처리하는 모듈
  - cancel() 메소드: task를 중지
  - resume() 메소드: task가 일시중지되어 있던 경우, 다시 시작
  - suspend() 메소드: task를 일시중지 (인스턴스 생성시 초기값은 suspend 상태)
- [출처](https://ios-development.tistory.com/740) : 사실상 애플디벨로퍼 문서





#### Example Code

```swift
import Foundation
import Alamofire

class NetworkManager {
    
    struct Login: Encodable {
        let email: String
        let password: String
    }
    struct Profile: Decodable {
        let name: String
        let image: String
    }
    
    let baseURL = "http://test.kr/login"
    let login = Login(email: "tmp@swift.kr", password: "p*ssw*rd")
    
    func request(with url: URL, completion: @escaping (Result<Profile, Error>) -> Void) {
        AF.request(baseURL, method: .get)
            .responseDecodable(of: Profile.self) { reponse in
                switch reponse.result {
                case let .success(data):
                    completion(.success(data))
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    func requestPost(with url: URL) {
        AF.request(baseURL,
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default)
            .responseString { response in
                debugPrint("Response: \(response)")
            }
    }
    
}
```



















