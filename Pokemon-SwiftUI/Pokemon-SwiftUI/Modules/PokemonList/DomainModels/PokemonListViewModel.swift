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
    func loadMoreIfNeeded(_ index: Int)
    func onDetail(pokemon: PokemonInfo)
    
    func getPokemon(from index: Int) -> PokemonInfo?
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
    func loadMoreIfNeeded(_ index: Int) {}
    func onDetail(pokemon: PokemonInfo) {}
    func getPokemon(from index: Int) -> PokemonInfo? {
        return nil
    }
}

final class PokemonListViewModelImpl: PokemonListViewModel {

    @Published private(set) var isLoading: Bool = false
    @Published private(set) var pokemons: [PokemonInfo] = []
    @Published var error: UIError? = nil
    
    private let cancellableBag = CancellableBag()
    private let activityIndicator = ActivityIndicator()
    private let errorIndicator = ErrorIndicator<UIError>()
    
    private let limit: Int = 100
    private var offset: Int = 0
    
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
        fetchPokemons(with: offset, and: limit)
    }
    
    func loadMoreIfNeeded(_ index: Int) {
        if return !isLoading && index == pokemons.count - 10 {
            fetchPokemons(with: offset, and: limit)
        }
    }
    
    func onDetail(pokemon: PokemonInfo) {
        navigator.navigateToDetail(pokemon: pokemon)
    }
    
    // Util functions
    func getPokemon(from index: Int) -> PokemonInfo? {
        return pokemons[safe: index]
    }
    
}

extension PokemonListViewModelImpl {
    private func fetchPokemons(with offset: Int, and limit: Int) {
        useCase.fetchPokemons(offset: offset, limit: limit)
            .trackActivity(activityIndicator)
            .trackError(errorIndicator)
            .sink(receiveValue: { [weak self] pokemons in
                guard let self = self else { return }
                self.pokemons += pokemons
                self.offset += pokemons.count
            }).store(in: &cancellableBag.cancellables)
    }
}
