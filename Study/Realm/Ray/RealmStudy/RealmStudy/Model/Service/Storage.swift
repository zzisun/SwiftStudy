import Foundation
import RealmSwift

final class Storage: StorageType {
    
    private let realm = try! Realm()
    
    
    func create(_ attendance: Attendance) {
        do {
            try realm.write {
                realm.add(attendance)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func read() -> [Attendance] {
        let attendance = realm.objects(Attendance.self)
        return Array(attendance)
    }
    
    func update(_ attendance: Attendance) {
        for info in read() where info.groupName == attendance.groupName {
            do {
                try realm.write {
                    info.students = attendance.students
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func delete(_ attendance: Attendance) {
        for info in read() where info.groupName == attendance.groupName {
            do {
                try realm.write {
                    realm.delete(info)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
