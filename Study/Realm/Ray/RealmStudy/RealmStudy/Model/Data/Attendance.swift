import Foundation
import RealmSwift

class Attendance: Object {
    @objc dynamic var groupName = ""
    var students = List<Student>()
    
    override static func primaryKey() -> String? {
        return "groupName"
    }
}

class Student: Object {
    @objc dynamic var name = ""
    var status = List<Status>()
}

class Status: Object {
    @objc dynamic let onTime = "출석"
    @objc dynamic let tardy = "지각"
    @objc dynamic let absent = "결석"
}
