//
//  PokemonDetailUseCase.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 18/05/2022.
//

import Combine

protocol PokemonDetailUseCase {
    var repository: PokemonRepository { get }
    
    func getPokemonDetail(id: String) -> AnyPublisher<PokemonDetail, CommonUIError>
}

final class PokemonDetailUseCaseImpl: PokemonDetailUseCase {
    let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func getPokemonDetail(id: String) -> AnyPublisher<PokemonDetail, CommonUIError> {
        return repository.getPokemonDetail(id: id)
            .mapError({ $0.asCommonUIError() })
            .map({ PokemonDetail(name: $0.name, imagePath: $0.imageURL) })
            .eraseToAnyPublisher()
    }
    
}
