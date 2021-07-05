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

#### Protocol과 Unit Test
> Protocol을 활용한 Test Code
- Protocol을 활용하면 해당 Protocol을 채택하는 다양한 객체를 쉽게 Test 가능
- 가짜 객체를 만들어서 진짜 객체의 로직을 Test 가능

```swift
import Foundation

struct Programmer {
    let coder: ProgrammingProtocol

    func coding() {
        coder.writeCode(time: 2, position: .iOS, pairs: ["V", "Lia"])
    }
}

struct Engineer {
    let engineer: ProgrammingProtocol
    
    func refactoring() {
        engineer.writeCode(time: 4, position: .BE, pairs: ["woody", "cooper"])
    }
}
```
- 상기 두 객체를 Test한다고 가정했을 때 Mock 객체를 활용하여 손쉽게 두 객체 모두 Test 가능
- 또한, 실제 객체를 사용하지 않고 Test하여도 실제 객체가 동일한 결과를 보여주는 것을 보장

```swift
struct ProgrammerTest {
    let coder: ProgrammingProtocol
    
    func coding() {
        coder.writeCode(time: 2, position: .iOS, pairs: ["V", "Lia"])
    }
}

struct EngineerTest {
    let engineer: ProgrammingProtocol
    
    func refactoring() {
        engineer.writeCode(time: 4, position: .BE, pairs: ["woody", "cooper"])
    }
}
```
- 같은 Protocol을 conform하는 테스트 객체 생성

```swift
class MockProgramming: ProgrammingProtocol {
    
    var codingCallCount = 0
    var codingAmountTime = 0
    var codingPosition: Position?
    var codingPairs: [String] = []
    
    func writeCode(time: Int, position: Position, pairs: [String]) {
        codingCallCount += 1
        codingAmountTime = time
        codingPosition = position
        codingPairs = pairs
    }
    
    func verifyCodingInfo(time: Int, position: Position, pairsMatcher: (([String])->Bool), file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(codingCallCount, 1, "call count",file: file, line: line)
        XCTAssertEqual(codingAmountTime, time, "time", file: file, line: line)
        XCTAssertEqual(codingPosition, position, "position", file: file, line: line)
        XCTAssertTrue(pairsMatcher(codingPairs), "pairs was \(codingPairs)", file: file, line: line)
        
    }

}
```
- Test에 사용할 Mock객체와 헬퍼 메서드 작성

```swift
class ProtocolTestTests: XCTestCase {

    func test_ShouldCoding() {
        let mockProgramming = MockProgramming()
        let programmer = ProgrammerTest(coder: mockProgramming)
        programmer.coding()
        mockProgramming.verifyCodingInfo(time: 2, position: .iOS, pairsMatcher: { pairs in
            pairs.count == 2 &&
                pairs.contains("Lia") &&
                pairs.contains("V")})
    }
    
    func test_ShouldRefactoring() {
        let mockProgramming = MockProgramming()
        let engineer = EngineerTest(engineer: mockProgramming)
        engineer.refactoring()
        mockProgramming.verifyCodingInfo(time: 4, position: .BE, pairsMatcher: { pairs in
            pairs.count == 2 &&
                pairs.contains("cooper") &&
                pairs.contains("woody")
        })
    }
}
```
- 단일 Mock 객체를 활용하여 같은 Protocol을 채택한 두 객체를 Test
- Protocol 기능 자체를 Test했기 때문에 가짜 객체를 Test했더라도, 진짜 객체에서도 동일하게 동작하는 것을 보장
