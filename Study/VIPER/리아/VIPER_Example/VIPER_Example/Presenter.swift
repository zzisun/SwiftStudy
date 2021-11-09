//
//  Presenter.swift
//  VIPER_Example
//
//  Created by Lia on 2021/11/09.
//

import Foundation

protocol CarsPresenterProtocol {
    func showCars(_ completion: (_ cars: [CarViewModel]) -> Void)
    func showCarDetail(for viewModel: CarViewModel)
    func showCreateCarScreen()
}

/*
 Presenter : UI 로직을 담당함
    - View의 이벤트를 받아, Interactor을 통해 처리함
    - Interactor에서 받은 데이터를 View에 전달함
    - Router에게 화면 전환 요청을 함
 */

class CarsPresenter: CarsPresenterProtocol {
    let interactor: CarsInteractorProtocol
    let router: CarsRouterProtocol
    
    init(interactor: CarsInteractorProtocol, router: CarsRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    // Interactor에게 네트워크 처리 요청
    // 받은 데이터를 View에게 전달
    func showCars(_ completion: ([CarViewModel]) -> Void) {
        interactor.getCars { (cars) in
            guard let cars = cars else {
                completion([])
                return
            }
            
            completion(createCarsViewModels(from: cars))
        }
    }
    
    // Router에게 화면 전환 요청
    func showCarDetail(for viewModel: CarViewModel) {
        router.showCarDetail(for: viewModel)
    }
    
    // Router에게 화면 전환 요청
    func showCreateCarScreen() {
        router.showCreateCarScreen()
    }
    
    // 내부 계산(car dto -> view용 car dto) 로직
    private func createCarsViewModels(from cars: [Car]) -> [CarViewModel] {
        return cars.map({ (car) -> CarViewModel in
            return CarViewModel(make: car.make, model: car.model)
        })
    }
}
