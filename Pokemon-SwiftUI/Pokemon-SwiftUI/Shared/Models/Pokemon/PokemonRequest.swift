//
//  PokemonRequest.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 18/05/2022.
//

import Foundation

struct PokemonRequest: NetworkRequest {
    
    let id: String
    
    var url: URL {
        return URL(string: Constants.baseURL + "/pokemon/\(id)")!
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


