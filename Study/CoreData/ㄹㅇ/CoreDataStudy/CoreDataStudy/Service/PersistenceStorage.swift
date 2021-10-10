import Foundation
import CoreData
import RxSwift
import RxCocoa
import RxRelay

final class Persistencestorage: PersistenceStorageType {
    
    private let storageKey = "News"
    private var store: [NewsInfo] = []
    private lazy var newData = BehaviorRelay<[NewsInfo]>(value: store)
    private let selectedData = BehaviorRelay<NewsInfo>(value: NewsInfo.empty())
    
    private lazy var persistenceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: storageKey)
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError()
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return persistenceContainer.viewContext
    }
    
    init() {
        fetchNews()
    }
    
    func newsData() -> Driver<[NewsInfo]> {
        return newData.asDriver()
    }
    
    func selectedNews() -> BehaviorRelay<NewsInfo> {
        return selectedData
    }
    
    func saveNews(_ info: NewsInfo) {
        let entity = NSEntityDescription.entity(forEntityName: "News", in: context)
        
        if let entity = entity {
            let news = NSManagedObject(entity: entity, insertInto: context)
            news.setValue(info.title, forKey: "title")
            news.setValue(info.content, forKey: "content")
            news.setValue("\(Date())", forKey: "date")
        }
        
        do {
            try context.save()
            store.append(info)
            newData.accept(store)
        } catch {
            print(error)
        }
    }
    
    @discardableResult
    func fetchNews() -> [News] {
        do {
            let fetchedData = try context.fetch(News.fetchRequest()) as! [News]
            var news: [NewsInfo] = []
            
            for data in fetchedData {
                let transformedData = NewsInfo(title: data.title ?? "", content: data.content ?? "", uuid: data.date ?? "")
                news.append(transformedData)
            }
            
            
            store = news
            newData.accept(store)
            return fetchedData
        } catch {
            print(error)
        }
        
        return []
    }
    
    func updateNews(_ new: NewsInfo) {
        let fetchedData = fetchNews()
        
        for info in fetchedData where info.date ==  new.uuid {
            info.setValue(new.title, forKey: "title")
            info.setValue(new.content, forKey: "content")
            info.setValue(new.uuid, forKey: "date")
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        fetchNews()
    }
    
    func deleteNews(_ uuid: String) {
        let fetcedData = fetchNews()
        
        for info in fetcedData where info.date == uuid {
            context.delete(info)
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        fetchNews()
    }
    
    func setupSelectedNews(_ info: NewsInfo) {
        selectedData.accept(info)
    }
}
