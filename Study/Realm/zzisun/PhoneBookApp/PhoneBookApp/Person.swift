//
//  Person.swift
//  PhoneBookApp
//
//  Created by 김지선 on 2021/11/02.
//

import Foundation
import RealmSwift
import UIKit

final class Person: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var phoneNumber: String = ""
    @objc dynamic var age: Int = 0
    @objc dynamic var work: String = ""
//    var image: UIImage = "👻".image()! //UIImage는 Object화 할 수 없다.
    
    convenience init(id: String, firstName: String, lastName: String, phoneNumber: String, age: Int, work: String) {
        self.init()
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.age = age
        self.work = work
    }
    
    override class func primaryKey() -> String? { return "id" }
}

