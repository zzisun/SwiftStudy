## Error Handling 학습

#### throw
> throw keyword를 사용하기
- 함수 선언부 파라미터 뒤에 throw keyword을 붙여서 사용
- 리턴값이 있을 경우 '->' 기호 전에 사용

```swift
enum MyError: Error {
    case failToGetData
    case hasNoData
    case emptyData
}

func update(_ data: Data?) throws {
    guard let data = data else {
        throw MyError.failToGetData
    }
    
    guard let index = inventory.firstIndex(of: data) else {
        throw MyError.hasNoData
    }
    
    guard data.count > 0 else {
        throw MyError.emptyData
    }
    
    inventory.remove(at: index)
    inventory.insert(data, at: index)
}
```

#### do - catch
>  catch 구문을 활용하기

```swift
do {
    try update(data)
} catch MyError.failToGetData {
    print("fail to get data")
} catch MyError.hasNoData {
    print("cannot update")
} catch MyError.emptyData {
    print("It's empty data")
} catch {
    print("unknown", error)
}
```
#### defer
> 에러 여부와 관련없이 반드시 실행되어야 하는 기능

```swift
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer {
            close(file)
        }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
```
