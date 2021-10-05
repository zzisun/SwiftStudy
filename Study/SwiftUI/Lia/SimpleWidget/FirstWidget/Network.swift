//
//  Network.swift
//  SimpleWidget
//
//  Created by Lia on 2021/10/05.
//

import Foundation
import Combine

enum EndPoint {
    static let scheme = "https"
    static let host   = "issue-tracker-swagger.herokuapp.com"
    
    static func url(path: String) -> URL? {
        var components = URLComponents()
        
        components.scheme = EndPoint.scheme
        components.host = EndPoint.host
        components.path = "\(path)"
        
        return components.url
    }
}

enum NetworkError: Error {
    case BadURL
    case BadRequest
    case BadResponse
    case DecodingError(Error)
    case EncodingError(Error)
    case Unknown
    case Status(Int)
}


protocol NetworkManagerable {
    func get<T: Decodable>(path: String, type: T.Type) -> AnyPublisher<T, NetworkError>
}


class NetworkManager {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
      self.session = session
    }
    
}


extension NetworkManager: NetworkManagerable {
    
    func get<T: Decodable>(path: String, type: T.Type) -> AnyPublisher<T, NetworkError> {
        guard let url = EndPoint.url(path: path) else {
            return Fail(error: NetworkError.BadURL).eraseToAnyPublisher()
        }
        let urlRequest = URLRequest(url: url)
        return request(with: urlRequest, type: type)
    }
    
    private func request<T: Decodable>(with request: URLRequest, type: T.Type) -> AnyPublisher<T, NetworkError> {
        
        return self.session.dataTaskPublisher(for: request)
            .mapError { _ in
                NetworkError.BadRequest
            }
            .flatMap { (data, response) -> AnyPublisher<T, NetworkError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: NetworkError.BadResponse).eraseToAnyPublisher()
                }
                guard 200..<300 ~= httpResponse.statusCode else {
                    return Fail(error:NetworkError.Status(httpResponse.statusCode)).eraseToAnyPublisher()
                }
                return Just(data)
                    .decode(type: T.self, decoder: JSONDecoder())
                    .mapError { error in
                        NetworkError.DecodingError(error)
                    }.eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
}


