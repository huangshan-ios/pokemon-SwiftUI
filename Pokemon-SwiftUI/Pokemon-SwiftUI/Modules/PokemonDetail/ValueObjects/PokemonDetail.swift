//
//  PokemonDetail.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 20/05/2022.
//

import Foundation

struct PokemonDetail {
    let name: String
    
    init(name: String = "") {
        self.name = name.capitalized
    }
}
