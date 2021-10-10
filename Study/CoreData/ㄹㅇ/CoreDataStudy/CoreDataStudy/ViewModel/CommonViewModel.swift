import Foundation

class CommonViewModel {
    
    let storage: PersistenceStorageType
    let sceneCoordinator: SceneCoordinatorType
    
    init(storage: PersistenceStorageType, sceneCoordinator: SceneCoordinatorType) {
        self.storage = storage
        self.sceneCoordinator = sceneCoordinator
    }
    
}
