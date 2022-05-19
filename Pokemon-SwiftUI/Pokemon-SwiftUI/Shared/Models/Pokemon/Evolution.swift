//
//  Evolution.swift
//  Pokedex
//
//  Created by TriBQ on 09/10/2020.
//

protocol EvolutionVending {
    var items: [EvolutionChain] { get }
}

extension EvolutionVending {
    var allChains: [EvolutionChain] {
        let items = self.items
        return items + items.flatMap { $0.allChains }
    }
}

struct Evolution: Codable, EvolutionVending {
    var items: [EvolutionChain] {
        get {
            if let chain = chain {
                return [chain]
            } else {
                return []
            }
        }
    }
    var babyTriggerItem: Item?
    var chain: EvolutionChain?
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case babyTriggerItem = "baby_trigger_item"
        case chain
        case id
    }
}

struct EvolutionChain: Codable, EvolutionVending {
    var items: [EvolutionChain] {
        return evolvesTo
    }
    
    var evolutionDetails: [EvolutionDetail] = []
    var evolvesTo: [EvolutionChain] = []
    var isBaby: Bool = false
    var species: PokemonInfoResponse = PokemonInfoResponse(name: "", url: "")
    
    enum CodingKeys: String, CodingKey {
        case evolutionDetails = "evolution_details"
        case evolvesTo = "evolves_to"
        case isBaby = "is_baby"
        case species
    }
}

struct EvolutionDetail: Codable {
    var item: PokemonInfoResponse?
    var gender: Int?
    var heldItem: PokemonInfoResponse?
    var knownMove: PokemonInfoResponse?
    var knownMoveType: PokemonInfoResponse?
    var location: PokemonInfoResponse?
    var minAffection: PokemonInfoResponse?
    var minBeauty: Int?
    var minHappiness: Int?
    var minLevel: Int?
    var needsOverworldRain: Bool?
    var partySpecies: PokemonInfoResponse?
    var partyType: PokemonInfoResponse?
    var relativePhysicalStats: Int?
    var timeOfDay: String?
    var tradeSpecies: PokemonInfoResponse?
    var trigger: PokemonInfoResponse?
    var turnUpsideDown: Bool?
    
    var evolutionTrigger: EvolutionTrigger {
        switch trigger?.name {
        case "level-up":
            return .level
        case "trade":
            return .trade
        case "use-item":
            return .item
        case "shed":
            return .shed

        default:
            return .level
        }
    }
    
    enum EvolutionTrigger {
        case level
        case trade
        case item
        case shed
    }
    
    enum CodingKeys: String, CodingKey {
        case gender
        case heldItem = "held_item"
        case item
        case knownMove = "known_move"
        case knownMoveType = "known_move_type"
        case location
        case minAffection = "min_affection"
        case minBeauty = "min_beauty"
        case minHappiness = "min_happiness"
        case minLevel = "min_level"
        case needsOverworldRain = "needs_overworld_rain"
        case partySpecies = "party_species"
        case partyType = "party_type"
        case relativePhysicalStats = "relative_physical_stats"
        case timeOfDay = "time_of_day"
        case tradeSpecies = "trade_species"
        case trigger
        case turnUpsideDown = "turn_upside_down"
    }
}

struct EvolutionTriggers: Codable {
    var count: Int = 0
    var next, previous: String?
    var results: [PokemonInfoResponse] = []
}
