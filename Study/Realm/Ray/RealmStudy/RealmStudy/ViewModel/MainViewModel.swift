import Foundation

final class MainViewModel {
    
    private let storage: StorageType
    
    init(_ storage: StorageType) {
        self.storage = storage
    }
    
    func saveInfo(of attendance: Attendance) {
        storage.create(attendance)
    }
    
    func fetchAttendanceInfo() -> [Attendance] {
        return storage.read()
    }
    
    func updateInfo(to attendance: Attendance) {
        storage.update(attendance)
    }
    
    func deleteInfo(from attendance: Attendance) {
        storage.delete(attendance)
    }
}
