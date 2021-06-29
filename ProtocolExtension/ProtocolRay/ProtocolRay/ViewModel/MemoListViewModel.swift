import Foundation
import RxSwift
import RxCocoa

class MemoListViewModel: CommonViewModel {
    
    var memoList:Observable<[Memo]> {
        return storage.memoList()
    }
}
