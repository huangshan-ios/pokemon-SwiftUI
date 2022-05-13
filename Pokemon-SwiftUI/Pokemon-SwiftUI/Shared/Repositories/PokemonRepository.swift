//
//  PokemonRepository.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 09/05/2022.
//

import Combine
import Foundation

protocol PokemonRepository {
    var networkService: NetworkProvider { get }
    
    func fetchPokemons() -> AnyPublisher<PokemonsResponse, NetworkError>
    func detailPokemon(url: String) -> AnyPublisher<Void, NetworkError>
}

final class PokemonListRepositoryImpl: PokemonRepository {
    
    let networkService: NetworkProvider
    
    init(networkService: NetworkProvider) {
        self.networkService = networkService
    }
    
    func fetchPokemons() -> AnyPublisher<PokemonsResponse, NetworkError> {
        return networkService
            .request(PokemonsRequest(offset: 100, limit: 100))
            .eraseToAnyPublisher()
    }
    
    func detailPokemon(url: String) -> AnyPublisher<Void, NetworkError> {
        return .just(())
    }
    
}
