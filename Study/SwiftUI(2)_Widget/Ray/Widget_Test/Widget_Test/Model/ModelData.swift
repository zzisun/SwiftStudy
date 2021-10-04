import Foundation
import Combine

final class ModelData {
    
    @Published var todoList: [TodoList] = [
        TodoList(id: 0, title: "SwiftUI 학습", content: "SwiftUI로 위젯 만들기", registeredTime: "21.10.04 09:51"),
        TodoList(id: 1, title: "zzisun 괴롭히기", content: "집 찾아가기", registeredTime: "21.10.04 10:51"),
        TodoList(id: 2, title: "lia 괴롭히기", content: "학교 찾아가기", registeredTime: "21.10.04 11:51")
    ]
    
}
