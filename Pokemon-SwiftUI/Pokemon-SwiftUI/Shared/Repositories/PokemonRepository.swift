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
    
    func fetchPokemons(offset: Int, limit: Int) -> AnyPublisher<PokemonListResponse, NetworkError>
    func loadDetailPokemon(id: String) -> AnyPublisher<PokemonResponse, NetworkError>
}

final class PokemonListRepositoryImpl: PokemonRepository {
    
    let networkService: NetworkProvider
    
    init(networkService: NetworkProvider) {
        self.networkService = networkService
    }
    
    func fetchPokemons(offset: Int, limit: Int) -> AnyPublisher<PokemonListResponse, NetworkError> {
        return networkService
            .request(PokemonListRequest(offset: offset, limit: limit))
            .eraseToAnyPublisher()
    }
    
    func loadDetailPokemon(id: String) -> AnyPublisher<PokemonResponse, NetworkError> {
        return networkService
            .request(PokemonRequest(id: id))
            .eraseToAnyPublisher()
    }
    
}
