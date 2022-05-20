//
//  PokemonListNavigator.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 09/05/2022.
//

import UIKit

protocol PokemonListNavigator {
    var navigationController: UINavigationController? { get }
    
    func navigateToDetail(pokemon: PokemonInfo)
}

final class PokemonListNavigatorImpl: PokemonListNavigator {
    
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func navigateToDetail(pokemon: PokemonInfo) {
        let repository = PokemonRepositoryImpl(networkService: NetworkService())
        let useCase = PokemonDetailUseCaseImpl(repository: repository)
        let id = pokemon.url.split(separator: "/").last ?? ""
        let viewModel = PokemonDetailViewModelImpl(pokemonId: "\(id)", useCase: useCase)
        let viewController = BaseHostingController(view: PokemonDetailView(viewModel: viewModel))
        navigationController?.pushViewController(viewController, animated: true)
    }
}
