import UIKit

enum Scene {
    case main(MainViewModel)
    case add(AddViewModel)
    case edit(EditViewModel)
}

extension Scene {
    func instantiate(from storyboard: String = "Main") -> UIViewController {
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        
        switch self {
        
        case .main(let viewModel):
            
            guard let nav = storyboard.instantiateViewController(withIdentifier: "Nav") as? UINavigationController else {
                fatalError()
            }
            
            guard var mainVC = nav.viewControllers.first as? MainViewController else {
                fatalError()
            }
            mainVC.bind(viewModel: viewModel)
            return nav
            
        case .add(let viewModel):
            
            guard var addVC = storyboard.instantiateViewController(withIdentifier: "AddVC") as? AddViewController else {
                fatalError()
            }
            
            addVC.bind(viewModel: viewModel)
            return addVC
            
        case .edit(let viewModel):
            
            guard var editVC = storyboard.instantiateViewController(withIdentifier: "EditVC") as? EditViewController else {
                fatalError()
            }
            
            editVC.bind(viewModel: viewModel)
            return editVC
        }
    }
}
