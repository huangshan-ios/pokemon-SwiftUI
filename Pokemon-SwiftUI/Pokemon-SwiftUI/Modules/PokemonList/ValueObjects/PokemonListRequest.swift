//
//  PokemonListRequest.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 10/05/2022.
//

import Foundation

struct PokemonListRequest: NetworkRequest {
    
    let offset: Int
    let limit: Int
    
    var url: URL {
        return URL(string: "https://pokeapi.co/api/v2/pokemon/?offset=\(offset)&limit=\(limit)")!
    }
    
    var method: HTTPMethod {
        return .GET
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    var parameters: [String : String]? {
        return nil
    }

}
