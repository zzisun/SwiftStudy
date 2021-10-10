import UIKit
import RxSwift

final class MainViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MainViewModel!
    private let disposedBag = DisposeBag()
    @IBOutlet weak var newsListTableView: UITableView!
    @IBOutlet weak var addNewsButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup() {
        setupTableView()
        setupAddNewsButton()
        bindData()
    }
}

private extension MainViewController {
    
    private func setupTableView() {
        let nib = UINib(nibName: "NewsCell", bundle: nil)
        newsListTableView.register(nib, forCellReuseIdentifier: "NewsCell")
        
        newsListTableView.rx.modelSelected(NewsInfo.self)
            .subscribe(onNext: { [unowned self] newsInfo in
                self.viewModel.makeEditAction(newsInfo)
            }).disposed(by: disposedBag)
    }
    
    private func setupAddNewsButton() {
        addNewsButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.makeAddNewsAction()
            }).disposed(by: disposedBag)
    }
    
    private func bindData() {
        viewModel.newsInfo
            .drive(newsListTableView.rx.items(cellIdentifier: "NewsCell", cellType: NewsCell.self)) { _, news, cell in
                cell.configure(news)
            }.disposed(by: disposedBag)
    }
}
