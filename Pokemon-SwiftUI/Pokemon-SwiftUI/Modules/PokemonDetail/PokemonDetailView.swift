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
            
            if let imageURL = viewModel.pokemon.imageURL {
                AsyncImage(url: imageURL,
                           placeholder: { loadingView },
                           image: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                })
                .frame(width: 200, height: 200)
            }
            
            if viewModel.isLoading {
                loadingView
            }
            
        }
        .onAppear(perform: { viewModel.onAppear() })
        .navigationTitle(viewModel.pokemon.name)
        .showErrorAlert($viewModel.error)
    }
    
    private var loadingView: some View {
        return ProgressView()
            .background(Color.clear)
    }
}

struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetailView(viewModel: PokemonDetailViewModelPreview())
    }
}
