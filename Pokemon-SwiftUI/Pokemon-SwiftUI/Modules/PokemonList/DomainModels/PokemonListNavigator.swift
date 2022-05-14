//
//  PokemonListNavigator.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 09/05/2022.
//

import Foundation

protocol PokemonListNavigator {
    func navigateToDetail(pokemon: PokemonInfo)
}

final class PokemonListNavigatorImpl: PokemonListNavigator {
    func navigateToDetail(pokemon: PokemonInfo) {
        print("Navigate to Pokemon Detail")
    }
}
