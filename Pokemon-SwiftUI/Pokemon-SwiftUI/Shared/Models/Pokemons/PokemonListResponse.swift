//
//  PokemonListResponse.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 08/05/2022.
//

import Foundation

struct PokemonListResponse: Codable {
    var count: Int = 0
    var next: String?
    var previous: String?
    var results: [PokemonInfoResponse] = []
}

struct PokemonInfoResponse: Codable {
    let name: String
    let url: String
}
