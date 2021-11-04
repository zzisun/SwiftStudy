//
//  People.swift
//  PhoneBookApp
//
//  Created by 김지선 on 2021/11/02.
//

import Foundation
import RealmSwift
import RxSwift

class DBManager {
    private let database: Realm
    static let shared = DBManager()
    
    private init() {
        do {
            database = try Realm()
        }
        catch {
            print("Error in DBManager")
            fatalError(error.localizedDescription)
        }
    }

    func fetch() -> [Person] { // Result와 Resullts가 다르다는 점!
        return database.objects(Person.self).array
    }
    
    func fetchRx() -> Observable<[Person]> {
        return Observable.create { emitter in // 여기서 just쓰니까 빌드오류는 안생기지만 데이터가 제대로 안넘어온다.
            emitter.onNext(self.fetch())
            return Disposables.create()
        }
    }
    
    func add(person: Person) {
        do {
            try database.write{
                database.add(person)
            }
        } catch {
            print("Error in add")
        }
    }
    
    func delete(person: Person) {
        do {
            try database.write{
                database.delete(person)
            }
        } catch {
            print("Error in delete")
        }
    }
    
    func update(person: Person) {
        
    }
}

extension Results {
    var array: [Element] {
        return self.count > 0 ? self.map { $0 } : []
    }
}
