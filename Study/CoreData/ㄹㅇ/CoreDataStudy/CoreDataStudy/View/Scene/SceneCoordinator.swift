import UIKit
import RxSwift
import RxCocoa

extension UIViewController {
    var sceneViewController: UIViewController {
        return self.children.first ?? self
    }
}

final class SceneCoordinator: SceneCoordinatorType {
    
    private var window: UIWindow
    private var currentVC: UIViewController
    private let disposedBag = DisposeBag()
    
    init(window: UIWindow) {
        self.window = window
        currentVC = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable {
        
        let subject = PublishSubject<Void>()
        let target = scene.instantiate()
        
        switch style {
        case .root:
            currentVC = target.sceneViewController
            window.rootViewController = target
            subject.onCompleted()
        
        case .push:
            guard let nav = currentVC.navigationController else {
                subject.onError(TransitionError.NavigationControllerMissing)
                break
            }
            
            nav.rx.willShow
                .subscribe(onNext: { event in
                    self.currentVC = event.viewController.sceneViewController
                }).disposed(by: disposedBag)
            
            nav.pushViewController(target, animated: animated)
            currentVC = target.sceneViewController
        }
        
        return subject.ignoreElements().asCompletable()
    }
    
    @discardableResult
    func close(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        
        if let presentingVC = self.currentVC.presentingViewController {
            self.currentVC.dismiss(animated: animated) {
                self.currentVC = presentingVC.sceneViewController
                subject.onCompleted()
            }
        } else if let nav = self.currentVC.navigationController {
            guard nav.popViewController(animated: animated) != nil else {
                subject.onError(TransitionError.cannotPopViewController)
                return subject.ignoreElements().asCompletable()
            }
            self.currentVC = nav.viewControllers.last!
            subject.onCompleted()
        } else {
            subject.onError(TransitionError.unknown)
        }
        
        return subject.ignoreElements().asCompletable()
    }
}
