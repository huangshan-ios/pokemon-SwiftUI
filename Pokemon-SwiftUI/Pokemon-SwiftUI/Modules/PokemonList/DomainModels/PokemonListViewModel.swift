//
//  PokemonListViewModel.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 08/05/2022.
//

import Foundation
import SwiftUI
import Combine

protocol PokemonListViewModel: ObservableObject, ViewModelType {
    var useCase: PokemonListUseCase { get }
    var navigator: PokemonListNavigator { get }
    
    var isLoading: Bool { get }
    var pokemons: [PokemonInfo] { get }
    var error: NetworkError { get }
    
    func fetchPokemons()
    func onDetail(pokemon: PokemonInfo)
}

final class PokemonListViewModelPreview: PokemonListViewModel {
    
    let useCase: PokemonListUseCase = PokemonListUseCaseImpl(repository: PokemonListRepositoryImpl(networkService: NetworkService()))
    let navigator: PokemonListNavigator = PokemonListNavigatorImpl()
    
    @Published private(set) var pokemons: [PokemonInfo] = [PokemonInfo(name: "bulbasaur", url: ""),
                                                           PokemonInfo(name: "ivysaur", url: ""),
                                                           PokemonInfo(name: "venusaur", url: ""),
                                                           PokemonInfo(name: "charmander", url: ""),
                                                           PokemonInfo(name: "charmeleon", url: "")]
    @Published private(set) var error: NetworkError = .invalidJSON
    @Published private(set) var isLoading: Bool = false

    func fetchPokemons() {}
    func onDetail(pokemon: PokemonInfo) {}
}

final class PokemonListViewModelImpl: PokemonListViewModel {
    
    @Published private(set) var pokemons: [PokemonInfo] = []
    @Published private(set) var error: NetworkError = .invalidJSON
    @Published private(set) var isLoading: Bool = false
    
    private let activityIndicator = ActivityIndicator()
    private let errorIndicator = ErrorIndicator<NetworkError>()
    
    let useCase: PokemonListUseCase
    let navigator: PokemonListNavigator
    
    init(_ useCase: PokemonListUseCase, navigator: PokemonListNavigator) {
        self.useCase = useCase
        self.navigator = navigator
        
        setupViewModel()
    }
    
    func setupViewModel() {
        activityIndicator.loading
            .assign(to: &$isLoading)
        
        errorIndicator.errors
            .assign(to: &$error)
    }
    
    func fetchPokemons() {
        useCase.fetchPokemons()
            .trackActivity(activityIndicator)
            .trackError(errorIndicator)
            .assign(to: &$pokemons)
    }
    
    func onDetail(pokemon: PokemonInfo) {
        navigator.navigateToDetail(pokemon: pokemon)
    }
    
}
