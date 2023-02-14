## Async & Await
- 비동기처리를 간결하게 할 수 있는 문법(completionHanlder / dispatchQueue등 대신 사용)
- async에서의 스레드 관리
  - A함수에서 B함수를 호출하면(async), A함수가 실행되던 스레드 제어권을 B에게 전달
  - B함수는 async이기 때문에 스레드의 제어권을 포기하는 suspend가 가능(B가 suspend되면 A도 suspend)
  - suspend되면 스레드의 제어권은 system으로 가고 system은 제어권을 활용해 다른 작업
  - 일시 중단된 비동기 함수가 resume
  - B함수가 종료되면 A함수에게 스레드 제어권을 반납

## 간단한 예시
```swift
func test() -> async throws -> Image
let image = try await test()
```


## 적용전
```swift
@objc private func didTapButton() {
  guard let url = URL(string: "https://reqres.in/api/users?page=2") else { return }
  self.requestImageURL(requestURL: url) { [weak self] urlString in
    DispatchQueue.global().async {
      guard
        let url = URL(string: urlString),
        let data = try? Data(contentsOf: url)
      else { return }
      DispatchQueue.main.async {
        self?.imageView.image = UIImage(data: data)
      }
    }
  }
}

func requestImageURL(requestURL: URL, completion: @escaping (String) -> Void) {
  URLSession.shared.dataTask(
    with: requestURL,
    completionHandler: { data, response, _ in
      guard
        let data = data,
        let httpResponse = response as? HTTPURLResponse,
        200..<300 ~= httpResponse.statusCode
      else { return }
      let decoder = JSONDecoder()
      if let decoded = try? decoder.decode(MyModel.self, from: data) {
        completion(decoded.data.first?.avatar ?? "")
      }
    }).resume()
}
```

## 적용후
```swift
@objc private func didTapButton() {
  guard let url = URL(string: "https://reqres.in/api/users?page=2") else { return }

  async {
    guard
      let imageURL = try? await self.requestImageURL(requestURL: url),
      let url = URL(string: imageURL),
      let data = try? Data(contentsOf: url)
    else { return }
    print(Thread.isMainThread) // true
    self.imageView.image = UIImage(data: data)
  }
}

func requestImageURL(requestURL: URL) async throws -> String {
  print(Thread.isMainThread) // false
  let (data, _) = try await URLSession.shared.data(from: requestURL)
  return try JSONDecoder().decode(MyModel.self, from: data).data.first?.avatar ?? ""
}
```

## async 블록으로 감싸서 호출하는 경우 depreacted
```swift
Task { // async대신 Task 사용
  guard
    let imageURL = try? await self.requestImageURL(requestURL: url),
    let url = URL(string: imageURL),
    let data = try? Data(contentsOf: url)
  else { return }
  print(Thread.isMainThread) // true
  self.imageView.image = UIImage(data: data)
}
```

## SwiftUI .task
- view가 나타날 때 수행할 비동기 작업을 위해 사용하는 modifier
- iOS 15부터 onAppear를 대신해서 사용
- onAppear보다 좋은점은 view와 같은 lifeCycle을 지님
- 즉, task완료 전에 view가 사라지면 system이 알아서 task를 취소함

```swift
var body: some View {
    List {
        ForEach(self.viewModel.names, id: \.self) { name in
            Text(name)
        }
    }.task ✅ {
        self.viewModel.requestNames() ✅
    }
}
```
