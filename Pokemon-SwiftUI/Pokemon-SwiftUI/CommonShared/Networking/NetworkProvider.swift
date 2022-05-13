//
//  NetworkProvider.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 06/05/2022.
//

import Foundation
import Combine

enum NetworkError: Error {
    case invalidRequest(Error)
    case invalidResponse(Error)
    case invalidJSON
    case other(Error)
    
    var errorCode: Int {
        switch self {
        case .invalidRequest, .invalidJSON:
            return 0
        case .invalidResponse:
            return 1
        case .other:
            return 3
        }
    }
}

protocol NetworkProvider {
    func request<T: Codable>(_ request: NetworkRequest) -> AnyPublisher<T, NetworkError>
}
