import Foundation

struct NewsInfo {
    var title:String
    var content:String
    var uuid:String
    
    static func empty() -> NewsInfo {
        return NewsInfo(title: "", content: "", uuid: "")
    }
}
