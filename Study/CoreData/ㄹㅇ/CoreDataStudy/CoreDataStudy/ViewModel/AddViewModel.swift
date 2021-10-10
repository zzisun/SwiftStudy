import Foundation

final class AddViewModel: CommonViewModel {
    
    func saveButtonTouched(_ title: String, _ content: String) {
        saveNewsInformation(title, content)
        makeCloseAction()
    }
    
    func saveNewsInformation(_ title:String, _ content: String) {
        let newsInfo = NewsInfo(title: title, content: content, uuid: "\(Date())")
        storage.saveNews(newsInfo)
    }
    
    func makeCloseAction() {
        sceneCoordinator.close(animated: true)
    }
}
