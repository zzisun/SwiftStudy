import UIKit
import SnapKit
import Then

final class MainViewController: UIViewController {
    
    private let viewModel: MainViewModel
    
    private lazy var mainCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
        $0.backgroundColor = .lightGray
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    init(_ viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

private extension MainViewController {
    
    private func setup() {
        setupMainView()
        setupMainCollectionView()
    }
    
    private func setupMainView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "출석 관리"
    }
    
    private func setupMainCollectionView() {
        view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
