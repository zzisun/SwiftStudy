#### Protocol Extension 학습하기
> Protocol + Extension을 활용한 코드

```swift
import UIKit

protocol ViewModelBindableType {
    
    associatedtype ViewModelType
    
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

//Protocol Extension 학습코드
extension ViewModelBindableType where Self: UIViewController {
    mutating func bind(viewModel: ViewModelType) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        bindViewModel()
    }
}
```

- ViewController가 해당 Protocol을 채택하면 아래와 같이 간결한 코드 구현이 가능해 짐

```swift
import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoListViewModel!
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var addButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.memoList
            .bind(to: listTableView.rx.items(cellIdentifier: "cell")) { _, memo, cell in
                cell.textLabel?.text = memo.content
            }.disposed(by: rx.disposeBag)
    }
}
```
- 개별 ViewController에서 bindViewModel 메서드를 호출할 필요가 없기 때문에 코드가 단순해짐

```swift
import UIKit

enum Scene {
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        
        case .list(let viewModel):
            guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else {
                fatalError()
            }
            guard var listVC = nav.viewControllers.first as? MemoListViewController else {
                fatalError()
            }
            
            listVC.bind(viewModel: viewModel)
            return nav
        }
    }
}
```
- 해당 protocol의 bind 메서드는 이와같이 Scene 이동 코드를 구현하는 곳에서 사용
