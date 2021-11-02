//
//  FetchUseCase.swift
//  RealmWidget
//
//  Created by Lia on 2021/11/02.
//

import Foundation
import Combine

final class UserFetcher {
    
    private var networkManager = NetworkManager()
    private var cancelBag = Set<AnyCancellable>()
    
    func excute(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        networkManager.get(path: "/user", type: [User].self)
            .receive(on: DispatchQueue.main)
            .sink { error in
                switch error {
                case .failure(let error): completion(.failure(error))
                case .finished: break
                }
            } receiveValue: { issues in
                completion(.success(issues))
            }.store(in: &cancelBag)
    }
    
}
