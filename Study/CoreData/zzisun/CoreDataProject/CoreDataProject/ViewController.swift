//
//  ViewController.swift
//  CoreDataProject
//
//  Created by 김지선 on 2021/10/12.
//

import UIKit
import CoreData

struct Person {
    
}

class ViewController: UIViewController {
    var container: NSPersistentContainer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // appDelegate에서 생성한 persistentContainer를 VC에 전달한다.
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        self.container = appDelegate?.persistentContainer
        fetchData()
        
    }

    @IBAction func addData(_ sender: Any) {
        addPerson()
    }
    func addPerson() {
        // entity를 가지고 온다.
        guard let entity = NSEntityDescription.entity(forEntityName: "PhoneBook", in: container!.viewContext) else { return  }
        let person = NSManagedObject(entity: entity, insertInto: container?.viewContext)
        person.setValue("test", forKey: "memo")
        person.setValue("zzisun", forKey: "name")
        person.setValue("010-1234-5678", forKey: "phoneNumber")
        
        do {
            try container?.viewContext.save()
        } catch {
            print("데이터가 저장되지 않음!", error.localizedDescription)
        }
    }
    
    func fetchData() {
        do {
            guard let contact = try container?.viewContext.fetch(PhoneBook.fetchRequest()) as? [PhoneBook] else {return}
            contact.forEach {
                print($0.name)
                print($0.phoneNumber)
                print($0.memo)
                
            }
        } catch {
            print("저장된 데이터가 없음!", error.localizedDescription)
        }
    }
}

