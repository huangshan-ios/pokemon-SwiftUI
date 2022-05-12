//
//  PokemonInfo.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 08/05/2022.
//

import Foundation

struct PokemonInfo: Identifiable {
    let id = UUID().uuidString
    let name: String
    let url: String
}
