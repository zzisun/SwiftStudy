import Foundation
import RxSwift
import RxCocoa

class CommonViewModel:NSObject {
    
    let title: Driver<String>
    let sceneCoordinator: SceneCoordinatorType
    let storage: MemoryStorageType
    
    init(title:String, sceneCoordinator: SceneCoordinatorType, storage: MemoryStorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
}
