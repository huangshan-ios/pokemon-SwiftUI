//
//  Species.swift
//  Pokedex
//
//  Created by Bui Quang Tri on 10/9/20.
//

import Foundation

struct Species: Codable {
    var id: Int = 1
    var name: String = ""
    var baseHappiness: Int = 0
    var flavorTextEntries: [FlavorTextEntry] = []
    var genderRate: Int = 1
    var eggGroup: [PokemonInfoResponse] = []
    var habitat: PokemonInfoResponse?
    var evolutionChain: APIResource = APIResource(url: "")
    var varieties: [PokemonSpeciesVariety] = []
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case baseHappiness = "base_happiness"
        case flavorTextEntries = "flavor_text_entries"
        case genderRate = "gender_rate"
        case eggGroup = "egg_groups"
        case habitat
        case evolutionChain = "evolution_chain"
        case varieties
    }
    
    var havingMega: Bool {
        return !megas.isEmpty
    }
    
    var megas: [PokemonInfoResponse] {
        return varieties.map({$0.pokemon}).filter({$0.name.contains("mega")})
    }
    
    var pokemon: PokemonInfoResponse {
        return varieties.map({$0.pokemon}).filter({!$0.name.contains("mega")}).first ?? PokemonInfoResponse(name: "", url: "")
    }
}

class FlavorTextEntry: Codable {
    var flavorText: String = ""
    var language: PokemonInfoResponse = PokemonInfoResponse(name: "", url: "")
    var version: PokemonInfoResponse = PokemonInfoResponse(name: "", url: "")

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
        case version
    }
}

struct PokemonSpeciesVariety: Codable {
    var isDefault: Bool = true
    var pokemon: PokemonInfoResponse = PokemonInfoResponse(name: "", url: "")
    
    enum CodingKeys: String, CodingKey {
        case isDefault = "is_default"
        case pokemon
    }
}
