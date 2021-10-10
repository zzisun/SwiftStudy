import Foundation
import RxCocoa

protocol PersistenceStorageType {
    
    func newsData() -> Driver<[NewsInfo]>
    
    func saveNews(_ info: NewsInfo)
    
    @discardableResult
    func fetchNews() -> [News]
    
    func updateNews(_ new: NewsInfo)
    
    func setupSelectedNews(_ info: NewsInfo)
    
    func selectedNews() -> BehaviorRelay<NewsInfo>
    
    func deleteNews(_ uuid: String)
}
