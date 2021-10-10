import UIKit
import RxSwift

final class EditViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: EditViewModel!
    
    private let disposedBag = DisposeBag()
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup() {
        viewModel.selectedData
            .asDriver()
            .map{$0.title}
            .drive(titleTextField.rx.text)
            .disposed(by: disposedBag)
        
        viewModel.selectedData
            .asDriver()
            .map{$0.content}
            .drive(contentTextView.rx.text)
            .disposed(by: disposedBag)
        
        saveButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                let newsInfo = NewsInfo(title: titleTextField.text ?? "", content: contentTextView.text ?? "", uuid: viewModel.selectedData.value.uuid)
                self.viewModel.updateNewsInfo(newsInfo)
            }).disposed(by: disposedBag)
        
        deleteButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                self.viewModel.deleteNews(viewModel.selectedData.value.uuid)
            }).disposed(by: disposedBag)
    }
}
