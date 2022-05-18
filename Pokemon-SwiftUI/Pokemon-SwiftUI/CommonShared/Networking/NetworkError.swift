//
//  NetworkError.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 18/05/2022.
//

import Foundation


enum NetworkError: Error {
    case invalidRequest(Error)
    case invalidResponse(Error)
    case invalidJSON
    case other(Error)
}
