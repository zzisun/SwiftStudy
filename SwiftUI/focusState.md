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
