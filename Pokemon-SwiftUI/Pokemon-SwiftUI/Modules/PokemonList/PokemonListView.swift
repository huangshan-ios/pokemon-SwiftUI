//
//  PokemonListView.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 05/05/2022.
//

import SwiftUI

struct PokemonListView<ViewModel>: View where ViewModel: PokemonListViewModel {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        
        NavigationView {
            ZStack {
                List {
                    ForEach(viewModel.pokemons) { pokemon in
                        Text(pokemon.name.capitalized)
                            .onTapGesture { viewModel.onDetail(pokemon: pokemon) }
                    }
                }
                .navigationTitle("Pokémons")
                .navigationBarTitleDisplayMode(.inline)
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
        .onAppear { viewModel.fetchPokemons() }
    }
    
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView(viewModel: PokemonListViewModelPreview())
    }
}
