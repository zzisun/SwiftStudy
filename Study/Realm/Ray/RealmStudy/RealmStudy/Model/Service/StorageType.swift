import Foundation

protocol StorageType {
    
    func create(_ attendance: Attendance)
    
    func read() -> [Attendance]
    
    func update(_ attendance: Attendance)
    
    func delete(_ attendance: Attendance)
}
