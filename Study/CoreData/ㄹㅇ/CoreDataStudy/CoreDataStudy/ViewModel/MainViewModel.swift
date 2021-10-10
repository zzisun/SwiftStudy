import Foundation
import RxCocoa

final class MainViewModel: CommonViewModel {
    
    lazy var newsInfo: Driver<[NewsInfo]> = {
        return storage.newsData()
    }()
    
    func makeAddNewsAction() {
        let addViewModel = AddViewModel(storage: storage, sceneCoordinator: sceneCoordinator)
        let addScene = Scene.add(addViewModel)
        sceneCoordinator.transition(to: addScene, using: .push, animated: true)
    }
    
    func makeEditAction(_ info: NewsInfo) {
        storage.setupSelectedNews(info)
        let editViewModel = EditViewModel(storage: storage, sceneCoordinator: sceneCoordinator)
        let editScene = Scene.edit(editViewModel)
        sceneCoordinator.transition(to: editScene, using: .push, animated: true)
    }
}
