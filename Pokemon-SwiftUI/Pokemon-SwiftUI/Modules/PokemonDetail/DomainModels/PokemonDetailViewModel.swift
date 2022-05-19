//
//  PokemonDetailViewModel.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 18/05/2022.
//

import Foundation

protocol PokemonDetailViewModel: ObservableObject {
    var pokemonId: String { get }
}

final class PokemonDetailViewModelPreview: PokemonDetailViewModel {
    
    let pokemonId: String = ""
    
}

final class PokemonDetailViewModelImpl: PokemonDetailViewModel {
    let pokemonId: String
    
    init(pokemonId: String) {
        self.pokemonId = pokemonId
    }
}
