import Foundation
import RxCocoa

final class EditViewModel: CommonViewModel {
    
    lazy var selectedData: BehaviorRelay<NewsInfo> = {
        return storage.selectedNews()
    }()
    
    func updateNewsInfo(_ info: NewsInfo) {
        storage.updateNews(info)
        sceneCoordinator.close(animated: true)
    }
    
    func deleteNews(_ uuid: String) {
        storage.deleteNews(uuid)
        sceneCoordinator.close(animated: true)
    }
}
