//
//  PokemonListViewModel.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 08/05/2022.
//

import Foundation
import SwiftUI
import Combine

protocol PokemonListViewModel: ObservableObject {
    var useCase: PokemonListUseCase { get }
    var navigator: PokemonListNavigator { get }
    
    var isLoading: Bool { get }
    var pokemons: [PokemonInfo] { get }
    var error: UIError? { get set }
    
    func onAppear()
    func onLoadMore()
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
    @Published var error: UIError? = nil
    @Published private(set) var isLoading: Bool = false
    
    func onAppear() {}
    func onLoadMore() {}
    func onDetail(pokemon: PokemonInfo) {}
}

final class PokemonListViewModelImpl: PokemonListViewModel {
    
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var pokemons: [PokemonInfo] = []
    @Published var error: UIError? = nil
    
    
    private let activityIndicator = ActivityIndicator()
    private let errorIndicator = ErrorIndicator<UIError>()
    
    let useCase: PokemonListUseCase
    let navigator: PokemonListNavigator
    
    init(_ useCase: PokemonListUseCase, navigator: PokemonListNavigator) {
        self.useCase = useCase
        self.navigator = navigator
        
        setupViewModel()
    }
    
    private func setupViewModel() {
        activityIndicator.loading
            .assign(to: &$isLoading)
        
        errorIndicator.errors
            .map({ error -> UIError? in
                return error
            })
            .assign(to: &$error)
    }
    
    func onAppear() {
        useCase.fetchPokemons()
            .trackActivity(activityIndicator)
            .trackError(errorIndicator)
            .assign(to: &$pokemons)
    }
    
    func onLoadMore() {
    }
    
    func onDetail(pokemon: PokemonInfo) {
        navigator.navigateToDetail(pokemon: pokemon)
    }
    
}
