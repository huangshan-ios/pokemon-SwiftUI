//
//  Machine.swift
//  Pokedex
//
//  Created by TriBQ on 10/10/2020.
//

import Foundation

struct MachineVersionDetail: Codable {
    var machine: APIResource
    var versionGroup: PokemonInfoResponse
    
    enum CodingKeys: String, CodingKey {
        case machine
        case versionGroup = "version_group"
    }
}

struct Machine: Codable {
    var id: Int
    var item: PokemonInfoResponse
    var move: PokemonInfoResponse
    var versionGroup: PokemonInfoResponse
    
    enum CodingKeys: String, CodingKey {
        case id
        case item
        case move
        case versionGroup = "version_group"
    }
}
