//
//  NetworkProvider.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 06/05/2022.
//

import Foundation
import Combine

protocol NetworkProvider {
    func request<T: Codable>(_ request: NetworkRequest) -> AnyPublisher<T, NetworkError>
}
