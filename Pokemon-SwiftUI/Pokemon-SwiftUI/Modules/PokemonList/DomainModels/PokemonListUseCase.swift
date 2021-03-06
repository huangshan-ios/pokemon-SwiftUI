//
//  PokemonListViewUseCase.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 09/05/2022.
//

import Combine
import Foundation

protocol PokemonListUseCase {
    
    var repository: PokemonRepository { get }
    
    func getPokemons(offset: Int, limit: Int) -> AnyPublisher<[PokemonInfo], CommonUIError>

}

final class PokemonListUseCaseImpl: PokemonListUseCase {
    
    let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func getPokemons(offset: Int, limit: Int) -> AnyPublisher<[PokemonInfo], CommonUIError> {
        return repository.getPokemons(offset: offset, limit: limit)
            .mapError({ $0.asCommonUIError() })
            .map ({ response in
                return response.results
                    .map { pokemon in
                        return PokemonInfo(name: pokemon.name,
                                           url: pokemon.url)
                    }
            }).eraseToAnyPublisher()
    }
    
}
