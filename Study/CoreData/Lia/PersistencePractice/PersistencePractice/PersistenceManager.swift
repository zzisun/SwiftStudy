//
//  PersistenceManager.swift
//  PersistencePractice
//
//  Created by Lia on 2021/10/12.
//

import UIKit
import CoreData

class PersistenceManager {
    static let shared: PersistenceManager = PersistenceManager()
    
    let appDelegate: AppDelegate? = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let EntityName = "Model"

    func save(user: User) {
        guard let context = context else { return }
        guard let entity = NSEntityDescription.entity(forEntityName: EntityName, in: context) else { return }
        
        let userObject = NSManagedObject(entity: entity, insertInto: context)
        userObject.setValue(user.id, forKey: "id")
        userObject.setValue(user.name, forKey: "name")
        userObject.setValue(user.email, forKey: "email")
        userObject.setValue(user.profileImage, forKey: "profileImage")
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchUsers() -> [User] {
        guard let context = context else { return [] }
        var models = [User]()
        
        do {
            let users = try context.fetch(Entity.fetchRequest())
            users.forEach {
                let user = User(id: Int($0.id), name: $0.name!, email: $0.email!, profileImage: $0.profileImage!)
                models.append(user)
            }
        } catch {
            print(error.localizedDescription)
        }
        return models
    }
    
}
