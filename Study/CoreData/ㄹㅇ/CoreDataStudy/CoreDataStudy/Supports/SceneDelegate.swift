import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        setupDependencyInjection()
    }
    
    func setupDependencyInjection() {
        let storage = Persistencestorage()
        let sceneCoordinator = SceneCoordinator(window: window!)
        let viewModel = MainViewModel(storage: storage, sceneCoordinator: sceneCoordinator)
        let scene = Scene.main(viewModel)
        sceneCoordinator.transition(to: scene, using: .root, animated: false)
    }
}

