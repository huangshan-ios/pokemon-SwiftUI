//
//  Item.swift
//  Pokedex
//
//  Created by TriBQ on 10/10/2020.
//

import Foundation

struct Item: Codable {
    var attributes: [PokemonInfoResponse] = []
    var babyTriggerFor: APIResource?
    var category: PokemonInfoResponse
    var cost: Int
    var effectEntries: [EffectEntry]
    var flavorTextEntries: [FlavorTextEntry]
    var flingEffect: PokemonInfoResponse?
    var flingPower: Int?
    var gameIndices: [GameIndex]
    var heldByPokemon: [ItemHolderPokemon]
    var id: Int
    var machines: [MachineVersionDetail]
    var name: String
    var names: [Name]
    var sprites: Sprites

    enum CodingKeys: String, CodingKey {
        case attributes
        case babyTriggerFor = "baby_trigger_for"
        case category, cost
        case effectEntries = "effect_entries"
        case flavorTextEntries = "flavor_text_entries"
        case flingEffect = "fling_effect"
        case flingPower = "fling_power"
        case gameIndices = "game_indices"
        case heldByPokemon = "held_by_pokemon"
        case id, machines, name, names, sprites
    }
}

struct EffectEntry: Codable {
    var effect: String
    var language: PokemonInfoResponse
    var shortEffect: String

    enum CodingKeys: String, CodingKey {
        case effect, language
        case shortEffect = "short_effect"
    }
}

struct GameIndex: Codable {
    var gameIndex: Int
    var generation: PokemonInfoResponse

    enum CodingKeys: String, CodingKey {
        case gameIndex = "game_index"
        case generation
    }
}

struct Name: Codable {
    var language: PokemonInfoResponse
    var name: String
}

struct Sprites: Codable {
    var spritesDefault: String

    enum CodingKeys: String, CodingKey {
        case spritesDefault = "default"
    }
}

struct ItemHolderPokemon: Codable {
    var pokemon: PokemonInfoResponse
    var versionDetails: [VersionDetail]

    enum CodingKeys: String, CodingKey {
        case pokemon
        case versionDetails = "version_details"
    }
}

struct VersionDetail: Codable {
    var rarity: Int
    var version: PokemonInfoResponse
}

struct Effect: Codable {
    var effect: String
    var language: PokemonInfoResponse
}

struct ItemFlingEffect: Codable {
    var id: Int
    var name: String
    var effectEntries: Effect
    var items: [PokemonInfoResponse]
    
    enum CodingKeys: String, CodingKey {
        case effectEntries = "effect_entries"
        case id, name, items
    }
}
