//
//  PokemonListViewUseCase.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 09/05/2022.
//

import Combine

protocol PokemonListUseCase {
    
    var repository: PokemonRepository { get }
    
    func fetchPokemons() -> AnyPublisher<[PokemonInfo], NetworkError>
    
}

final class PokemonListUseCaseImpl: PokemonListUseCase {
    
    let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func fetchPokemons() -> AnyPublisher<[PokemonInfo], NetworkError> {
        return repository.fetchPokemons()
            .map { response in
                return response.results
                    .map { pokemon in
                        return PokemonInfo(name: pokemon.name,
                                           url: pokemon.url)
                    }
            }.eraseToAnyPublisher()
    }
    
}
