//
//  type.swift
//  Pokedex
//
//  Created by TriBQ on 05/10/2020.
//

import Foundation

struct TypeResult: Codable {
    var slot: Int = 0
    var type: PokemonInfoResponse = PokemonInfoResponse(name: "", url: "")
}
