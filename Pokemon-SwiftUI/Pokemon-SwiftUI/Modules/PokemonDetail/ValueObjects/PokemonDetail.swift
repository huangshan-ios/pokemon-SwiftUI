//
//  PokemonDetail.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 20/05/2022.
//

import Foundation

struct PokemonDetail {
    let name: String
    let imageURL: URL?
    
    init(name: String = "", imagePath: String = "") {
        self.name = name.capitalized
        self.imageURL = URL(string: imagePath)
    }
}
