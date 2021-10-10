import UIKit
import RxSwift
import RxCocoa

final class AddViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: AddViewModel!
    private let disposedBag = DisposeBag()
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup() {
        setupTitleTextField()
        setupContentTextView()
        saveButtonTouched()
    }
}

private extension AddViewController {
    
    private func setupTitleTextField() {
        
    }
    
    private func setupContentTextView() {
        contentTextView.rx.didBeginEditing
            .subscribe(onNext: { _ in
                self.contentTextView.text = ""
                self.contentTextView.textColor = .black
            }).disposed(by: disposedBag)
        
        contentTextView.rx.didEndEditing
            .subscribe(onNext: { [unowned self] _ in
                if self.contentTextView.text.isEmpty {
                    self.contentTextView.textColor = .systemGray2
                    self.contentTextView.text = "내용을 입력해주세요."
                }
            }).disposed(by: disposedBag)
    }
    
    private func saveButtonTouched() {
        saveButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                let title = titleTextField.text ?? ""
                let content = contentTextView.text ?? ""
                self.viewModel.saveButtonTouched(title, content)
            }).disposed(by: disposedBag)
    }
}
