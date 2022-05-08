//
//  NetworkService.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 06/05/2022.
//

import Foundation
import Combine

final class NetworkService: NetworkProvider {
    
    func request<T>(_ request: NetworkRequest) -> AnyPublisher<T, NetworkError> where T : Decodable, T : Encodable {
        do {
            let urlRequest = try request.makeRequest()
            return URLSession.shared.dataTaskPublisher(for: urlRequest)
                .map(\.data)
                .receive(on: DispatchQueue.main)
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError({ error in
                    switch error {
                    case let errorResponse as URLError:
                        return .invalidResponse(errorResponse)
                    case is DecodingError:
                        return .invalidJSON
                    default:
                        return .other(error)
                    }
                })
                .eraseToAnyPublisher()
        } catch let error {
            return Fail(error: NetworkError.invalidRequest(error))
                .eraseToAnyPublisher()
        }
    }
    
}
