//
//  PokemonDetailView.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 18/05/2022.
//

import SwiftUI

struct PokemonDetailView<ViewModel>: View where ViewModel: PokemonDetailViewModel {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            if viewModel.isLoading {
                ProgressView()
                    .background(Color.clear)
            }
        }
        .onAppear(perform: { viewModel.onAppear() })
        .navigationTitle(viewModel.pokemon.name)
        .showErrorAlert($viewModel.error)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(viewModel: PokemonDetailViewModelPreview())
    }
}
