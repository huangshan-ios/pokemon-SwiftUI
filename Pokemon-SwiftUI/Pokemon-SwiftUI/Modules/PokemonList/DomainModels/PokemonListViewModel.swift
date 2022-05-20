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
    var error: CommonUIError? { get set }
    
    func onAppear()
    func loadMoreIfNeeded(_ index: Int)
    func onDetail(pokemon: PokemonInfo)
    
    func getPokemon(from index: Int) -> PokemonInfo?
}

final class PokemonListViewModelPreview: PokemonListViewModel {
    
    let useCase: PokemonListUseCase = PokemonListUseCaseImpl(repository: PokemonRepositoryImpl(networkService: NetworkService()))
    let navigator: PokemonListNavigator = PokemonListNavigatorImpl(navigationController: nil)
    
    @Published private(set) var pokemons: [PokemonInfo] = [PokemonInfo(name: "bulbasaur", url: ""),
                                                           PokemonInfo(name: "ivysaur", url: ""),
                                                           PokemonInfo(name: "venusaur", url: ""),
                                                           PokemonInfo(name: "charmander", url: ""),
                                                           PokemonInfo(name: "charmeleon", url: "")]
    @Published var error: CommonUIError? = nil
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
    @Published var error: CommonUIError? = nil
    
    private let cancellableBag = CancellableBag()
    private let activityIndicator = ActivityIndicator()
    private let errorIndicator = ErrorIndicator<CommonUIError>()
    
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
            .map({ error -> CommonUIError? in
                return error
            })
            .assign(to: &$error)
    }
    
    func onAppear() {
        guard pokemons.isEmpty else {
            return
        }
        fetchPokemons(with: offset, and: limit)
    }
    
    func loadMoreIfNeeded(_ index: Int) {
        guard !isLoading, index == pokemons.count - 10 else {
            return
        }
        fetchPokemons(with: offset, and: limit)
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
        useCase.getPokemons(offset: offset, limit: limit)
            .trackActivity(activityIndicator)
            .trackError(errorIndicator)
            .sink(receiveValue: { [weak self] pokemons in
                guard let self = self else { return }
                self.pokemons += pokemons
                self.offset += pokemons.count
            }).store(in: &cancellableBag.cancellables)
    }
}
