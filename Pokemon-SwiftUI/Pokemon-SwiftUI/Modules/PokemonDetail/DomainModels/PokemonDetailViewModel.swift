//
//  PokemonDetailViewModel.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 18/05/2022.
//

import Combine

protocol PokemonDetailViewModel: ObservableObject {
    var pokemonId: String { get }
    var useCase: PokemonDetailUseCase { get }
    
    var pokemon: PokemonDetail { get }
    var isLoading: Bool { get }
    var error: CommonUIError? { get set }
    
    func onAppear()
}

final class PokemonDetailViewModelPreview: PokemonDetailViewModel {
    
    let pokemonId: String = ""
    let useCase: PokemonDetailUseCase = PokemonDetailUseCaseImpl(repository: PokemonRepositoryImpl(networkService: NetworkService()))
    
    var pokemon: PokemonDetail = PokemonDetail()
    
    @Published var error: CommonUIError? = nil
    @Published private(set) var isLoading: Bool = false
    
    func onAppear() {}
    
}

final class PokemonDetailViewModelImpl: PokemonDetailViewModel {
    
    @Published private(set) var pokemon: PokemonDetail = PokemonDetail()
    @Published var error: CommonUIError? = nil
    @Published private(set) var isLoading: Bool = false
    
    private let activityIndicator = ActivityIndicator()
    private let errorIndicator = ErrorIndicator<CommonUIError>()
    
    let pokemonId: String
    let useCase: PokemonDetailUseCase
    
    init(pokemonId: String, useCase: PokemonDetailUseCase) {
        self.pokemonId = pokemonId
        self.useCase = useCase
        
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
        guard !pokemonId.isEmpty else {
            return
        }
        useCase.getPokemonDetail(id: pokemonId)
            .trackActivity(activityIndicator)
            .trackError(errorIndicator)
            .replaceError(with: PokemonDetail())
            .assign(to: &$pokemon)
    }
    
}
