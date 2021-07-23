# Error Handling



## Error 

### 1. 오류를 정의하자!

* 열거형으로 오류의 종류를 나타낸다.

* 빈 프로토콜인 Error를 채택하여 가독성을 준다 [Error](https://developer.apple.com/documentation/swift/error)

  ```swift
  enum RequestError: Error {
      case outOfRange
      case badRequest
      case notFound
      case internalServerError
  }
  ```

  

### 2. 오류를 던지자! *throws*

> Error를 던지고 함수를 종료한다.

```swift
func request() throws {
    ...
    if json.statusCode == 400 {
        throw RequestError.badRequest
    } else if json.statusCode == 404 {
        throw RequestError.notFound
    } else if json.statusCode == 500 {
        throw RequestError.internalServerError
    }
}
```



### 3. 오류를 처리하자! try, do-catch

* **try**: *throws*가 함께 선언된 메소드를 실행시킬 때 사용

* **do-catch**: *throws* 로 선언된 메소드에서 에러를 잡아서 처리할 때 사용

  ```swift
  func getImages() {
      do {
          try request()
      } catch RequestError.badRequest {
          print("Bad Request, 요청 실패")
      } catch RequestError.notFound {
             print("Not Found, 문서를 찾을 수 없음")
      } catch RequestError.internalServerError {
             print("Internal Server Error, 서버 내부 오류")
      } catch {
          print("알 수 없는 에러...")
      }
   
      print("다운로드가 완료!")
  }
  ```

  

## defer 후처리!

> 현재 코드 블럭을 나가기 전 꼭 실행해야하는 코드를 작성할 수 있다.

* 현재 코드범위 내에서 실행을 미루다가 범위를 벗어나기 직전 실행

* defer 구문 내부에 break, return 또는 오류를 던지는 코드 작성 ❌   --> 다음의 코드를 만난 후의 defer구문은 실행되지 않는다.

* 하나의 block내에서 역순으로 실행된다.

  ```swift
  func deferFuntion(throwError: Bool) throws {
      print("A")
      
      if throwError {
          throw RequestError.badRequest
      }
      
      defer {
          print("B")
          print("C")
      }
      
      defer {
          print("D")
      }
  }
  
  try? deferFuntion(throwError: true)
  // A
  
  try? deferFuntion(throwError: false)
  //A
  //D
  //B
  //C
  ```



🤔 

```swift
func send(error: GalleryError? = nil, completion: @escaping (Result<GalleryData.Body, GalleryError>) -> Void) {
        var components = URLComponents(string: GalleryRequest.url)
        var items: [URLQueryItem] = [
            URLQueryItem(name: "display", value: "\(display)"),
            URLQueryItem(name: "start", value: "\(start)")
        ]

        if !((10...100) ~= display && (1...1000) ~= start) {
            completion(.failure(.invalidArgument))
            return
        }

        if let error = error {
            if [.badRequest, .notFound, .internalServerError].contains(error) {
                items.append(URLQueryItem(name: "err", value: "\(error.rawValue)"))
            } else {
                completion(.failure(.invalidArgument))
                return
            }
        }

        components?.queryItems = items

        if let url = components?.url {
            URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                if let data = data {
                    do {
                        let json: GalleryData = try JSONDecoder().decode(GalleryData.self, from: data)
                        if json.statusCode == 200 {
                            completion(.success(json.body))
                        } else {
                            let galleryError = GalleryError(rawValue: json.statusCode) ?? .unknown
                            completion(.failure(galleryError))
                        }
                    } catch {
                        completion(.failure(.jsonError))
                    }
                } else {
                    completion(.failure(.unknown))
                }
            }).resume()
        }
    }
```


