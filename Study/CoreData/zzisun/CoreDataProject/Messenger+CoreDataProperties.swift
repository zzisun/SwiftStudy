//
//  Messenger+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by 김지선 on 2021/10/12.
//
//

import Foundation
import CoreData


extension Messenger {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Messenger> {
        return NSFetchRequest<Messenger>(entityName: "Messenger")
    }

    @NSManaged public var id: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var phoneBook: PhoneBook?

}

extension Messenger : Identifiable {

}
