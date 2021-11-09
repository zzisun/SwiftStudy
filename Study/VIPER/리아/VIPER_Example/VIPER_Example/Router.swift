//
//  Router.swift
//  VIPER_Example
//
//  Created by Lia on 2021/11/09.
//

import UIKit

protocol CarsRouterProtocol {
    func showCarDetail(for viewModel: CarViewModel)
    func showCreateCarScreen()
}

class CarsRouter: CarsRouterProtocol {
    let presentingViewController: UIViewController
    
    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }
    
    // DI 처리 메서드
     static func createCarsListModule() -> UIViewController {
         let carsListVC = CarsViewController()
         let carsAPIService: CarsAPIServiceProtocol = CarsAPIService()
         let carsInteractor: CarsInteractorProtocol = CarsInteractor(apiService: carsAPIService)
         let carsRouter: CarsRouterProtocol = CarsRouter(presentingViewController: carsListVC)
         let carsPresenter: CarsPresenterProtocol = CarsPresenter(interactor: carsInteractor, router: carsRouter)
         
         carsListVC.presenter = carsPresenter
         return carsListVC
     }
    
    // ViewController 생성 및 화면 전환
    func showCarDetail(for viewModel: CarViewModel) {
        guard let navigationController = presentingViewController.navigationController else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let carDetailViewController = storyboard.instantiateViewController(withIdentifier: "CarDetailViewController") as? CarDetailViewController
        carDetailViewController?.viewModel = viewModel
        
        navigationController.pushViewController(carDetailViewController!, animated: true)
    }
    
    // ViewController 생성 및 화면 전환
    func showCreateCarScreen() {
        guard let navigationController = presentingViewController.navigationController else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let carDetailViewController = storyboard.instantiateViewController(withIdentifier: "CreateCarViewController")
        
        navigationController.pushViewController(carDetailViewController, animated: true)
    }
}
