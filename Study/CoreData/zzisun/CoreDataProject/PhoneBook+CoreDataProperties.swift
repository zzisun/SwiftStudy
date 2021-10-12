//
//  PhoneBook+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by 김지선 on 2021/10/12.
//
//

import Foundation
import CoreData


extension PhoneBook {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhoneBook> {
        return NSFetchRequest<PhoneBook>(entityName: "PhoneBook")
    }

    @NSManaged public var phoneNumber: String?
    @NSManaged public var name: String?
    @NSManaged public var memo: String?

}

extension PhoneBook : Identifiable {

}
