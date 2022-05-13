//
//  PokemonsRequest.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 10/05/2022.
//

import Foundation

struct PokemonsRequest: NetworkRequest {
    
    let offset: Int
    let limit: Int
    
    var url: URL {
        return URL(string: Constants.baseURL + "/pokemon/?offset=\(offset)&limit=\(limit)")!
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
