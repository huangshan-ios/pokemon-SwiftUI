//
//  PokemonListRepository.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 09/05/2022.
//

import Combine
import Foundation

protocol PokemonListRepository {
    var networkService: NetworkProvider { get }
    
    func fetchPokemons() -> AnyPublisher<PokemonResponse, NetworkError>
}

final class PokemonListRepositoryImpl: PokemonListRepository {
    
    let networkService: NetworkProvider
    
    init(networkService: NetworkProvider) {
        self.networkService = networkService
    }
    
    func fetchPokemons() -> AnyPublisher<PokemonResponse, NetworkError> {
        return networkService
            .request(PokemonListRequest(offset: 100, limit: 100))
            .eraseToAnyPublisher()
    }
    
}
