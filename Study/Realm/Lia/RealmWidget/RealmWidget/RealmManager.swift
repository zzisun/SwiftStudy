//
//  RealmManager.swift
//  RealmWidget
//
//  Created by Lia on 2021/11/02.
//

import Foundation
import RealmSwift

final class RealmManager {
    let realm = try! Realm()
    
    func save<T:Object>(object: T) {
        try! realm.write {
            realm.add(object)
        }
    }

    func delete<T:Object>(object: T) {
        try! realm.write {
            realm.delete(object)
        }
    }
    
    func read<T:Object>(object: T) -> [T] {
        let objects = realm.objects(T.self)
        return objects
    }

}
