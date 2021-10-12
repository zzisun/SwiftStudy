//
//  ViewController.swift
//  PersistencePractice
//
//  Created by Lia on 2021/10/12.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        saveUsers()
        saveUsers()
        fetchUsers()
        deleteUser()
        fetchUsers()
    }

}


extension ViewController {
        
    func fetchUsers() {
        let users = PersistenceManager.shared.fetchUsers()
        print("all users: ", users)
    }
    
    func saveUsers() {
        let lia = User(id: 5,
                       name: "Lia",
                       email: "Lia316@p.ac.kr",
                       profileImage: "https://user-images.githubusercontent.com/73650994/136906993-42601a95-a52f-4cea-a559-8e2bf6c661d5.png")
        PersistenceManager.shared.save(user: lia)
    }
    
    func deleteUser() {
        print("is delete success?: ", PersistenceManager.shared.deleteUser(id: 0))
    }
    
}
