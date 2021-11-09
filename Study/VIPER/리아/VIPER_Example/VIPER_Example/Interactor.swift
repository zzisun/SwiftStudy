//
//  Interactor.swift
//  VIPER_Example
//
//  Created by Lia on 2021/11/09.
//

import Foundation

protocol CarsInteractorProtocol {
    func getCars(_ completion: (_ cars: [Car]?)-> Void)
}

/*
 Interactor : 비즈니스 로직 담당
    - 주로 api 통신 등, 네트워크 / 데이터베이스 처리
    - Presenter에게 데이터 전달
    - 데이터 (Entity) 처리
 */

class CarsInteractor: CarsInteractorProtocol {
    let apiService: CarsAPIServiceProtocol
    
    init(apiService: CarsAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    // 네트워크 처리
    // Presenter에게 데이터 전달
    func getCars(_ completion: ([Car]?) -> Void) {
        apiService.getCars { (cars, error) in
            guard let cars = cars else {
                completion([])
                return
            }
            
            completion(cars)
        }
    }
}

protocol CarsAPIServiceProtocol {
    func getCars(completion: (([Car]?, Error) -> Void))
}

class CarsAPIService : CarsAPIServiceProtocol {
    func getCars(completion: (([Car]?, Error) -> Void)) {}
}
