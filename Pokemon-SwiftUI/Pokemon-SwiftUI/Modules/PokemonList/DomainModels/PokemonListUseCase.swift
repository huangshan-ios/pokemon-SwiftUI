//
//  PokemonListViewUseCase.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 09/05/2022.
//

import Combine

protocol PokemonListUseCase {
    
    var repository: PokemonRepository { get }
    
    func fetchPokemons(offset: Int, limit: Int) -> AnyPublisher<[PokemonInfo], UIError>

}

final class PokemonListUseCaseImpl: PokemonListUseCase {
    
    let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func fetchPokemons(offset: Int, limit: Int) -> AnyPublisher<[PokemonInfo], UIError> {
        return repository.fetchPokemons(offset: offset, limit: limit)
            .mapError({ networkError in
                return UIError(id: networkError.errorCode,
                               messages: networkError.localizedDescription)
            })
            .map ({ response in
                return response.results
                    .map { pokemon in
                        return PokemonInfo(name: pokemon.name,
                                           url: pokemon.url)
                    }
            }).eraseToAnyPublisher()
    }
    
}
