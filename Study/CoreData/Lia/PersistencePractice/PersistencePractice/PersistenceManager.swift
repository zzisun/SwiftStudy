//
//  PersistenceManager.swift
//  PersistencePractice
//
//  Created by Lia on 2021/10/12.
//

import UIKit
import CoreData

class PersistenceManager {
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static let shared: PersistenceManager = PersistenceManager()
    
    lazy var context = self.persistentContainer.viewContext
    
    let EntityName = "Entity"

    func save(user: User) {
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
    
    @discardableResult func deleteUser(id: Int) -> Bool {
        
        do {
            let results = try context.fetch(Entity.fetchRequest())
            if !results.isEmpty && id < results.count {
                context.delete(results[id])
                try context.save()
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return true
    }
    
}
