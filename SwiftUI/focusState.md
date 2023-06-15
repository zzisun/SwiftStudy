## FocusState
- 현재 userinput을 받는 view를 알려주는 property wrapper
- single field랑 Boolean으로 bind
- multiple field랑 enum으로 bind

## Single Field Binding
```swift
struct ContentView: View {
    @FocusState private var isUsernameFocused: Bool
    @State private var username = "Anonymous"
    
    var body: some View {
        VStack {
            TextField("Enter your username", text: $username)
                .focused($isUsernameFocused)
            
            Button("Toggle Focus") {
                isUsernameFocused.toggle()
            }
        }
    }
}
```

## Multiple Fields Binding
```swift
struct ContentView: View {
    private enum FocusedField {
        case username, password
    }
    
    @FocusState private var focusedField: FocusedField?
    @State private var username = "Anonymous"
    @State private var password = "12345678"
    
    var body: some View {
        VStack {
            TextField("Enter your username", text: $username)
                .focused($focusedField, equals: .username)
            
            SecureField("Enter your password", text: $password)
                .focused($focusedField, equals: .password)
        }
        .onSubmit {
            if focusedField == .username {
                focusedField = .password
            } else {
                focusedField = nil
            }
        }
    }
}
```

## OnSubmit
- view modifier
- Text Field 등 View의 user input 결과처리를 위한 modifier

## TabView
- UIKit의 UITabBarController와 유사
- 하나의 화면에 여러 개의 View를 Tab 방식으로 보여줄 수 있음

```swift
struct ContentView : View {
  var body: some View {
    TabView {
      Text("The First Tab")
        .tabItem {
          Image(systemName: "1.square.fill")
          Text("First")
        }
      Text("The Second Tab")
        .tabItem {
          Image(systemName: "2.square.fill")
          Text("Second")
        }
      Text("The Third Tab")
        .tabItem {
          Image(systemName: "3.square.fill")
          Text("Third")
        }
    }
    .font(.headline)
  }
}
```
