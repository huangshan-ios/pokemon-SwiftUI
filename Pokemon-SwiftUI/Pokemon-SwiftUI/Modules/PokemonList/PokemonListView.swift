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
                    ForEach(viewModel.pokemons.indices, id: \.self) { index in
                        if let pokemon = viewModel.getPokemon(from: index) {
                            Text(pokemon.name.capitalized)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemBackground))
                                .onTapGesture {
                                    viewModel.onDetail(pokemon: pokemon)
                                }
                                .onAppear {
                                    viewModel.loadMoreIfNeeded(index)
                                }
                        }
                    }
                }
                .navigationTitle("Pokémons")
                .navigationBarTitleDisplayMode(.inline)
                if viewModel.isLoading {
                    ProgressView()
                        .background(Color.clear)
                }
            }
        }
        .onAppear(perform: { viewModel.onAppear() })
        .showErrorAlert($viewModel.error)
    }
    
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView(viewModel: PokemonListViewModelPreview())
    }
}
