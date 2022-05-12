//
//  PokemonListViewUseCase.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 09/05/2022.
//

import Combine

protocol PokemonListUseCase {
    
    var repository: PokemonListRepository { get }
    
    func fetchPokemons() -> AnyPublisher<[PokemonInfo], NetworkError>
    
}

final class PokemonListUseCaseImpl: PokemonListUseCase {
    
    let repository: PokemonListRepository
    
    init(repository: PokemonListRepository) {
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
