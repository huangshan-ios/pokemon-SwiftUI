//
//  PokemonDetailUseCase.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 18/05/2022.
//

import Combine

protocol PokemonDetailUseCase {
    var repository: PokemonRepository { get }
    
    func loadDetailPokemon(id: String) -> AnyPublisher<PokemonResponse, CommonUIError>
}

final class PokemonDetailUseCaseImpl: PokemonDetailUseCase {
    let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func loadDetailPokemon(id: String) -> AnyPublisher<PokemonResponse, CommonUIError> {
        return repository.loadDetailPokemon(id: id)
            .mapError({ $0.asCommonUIError() })
            .eraseToAnyPublisher()
    }
    
}
