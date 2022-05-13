//
//  PokemonListViewUseCase.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 09/05/2022.
//

import Combine
import SwiftUI

protocol PokemonListUseCase {
    
    var repository: PokemonRepository { get }
    
    func fetchPokemons() -> AnyPublisher<[PokemonInfo], UIError>
    
}

final class PokemonListUseCaseImpl: PokemonListUseCase {
    
    let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func fetchPokemons() -> AnyPublisher<[PokemonInfo], UIError> {
        return repository.fetchPokemons()
            .mapError({ networkError in
                return UIError(id: networkError.errorCode,
                               messages: networkError.localizedDescription)
            })
            .map { response in
                return response.results
                    .map { pokemon in
                        return PokemonInfo(name: pokemon.name,
                                           url: pokemon.url)
                    }
            }.eraseToAnyPublisher()
    }
    
}
