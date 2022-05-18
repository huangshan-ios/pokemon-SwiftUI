//
//  UIError.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 14/05/2022.
//

import Foundation

struct CommonUIError: Identifiable, Error {
    let id: Int
    let message: String
    
    static let somethingWhenWrong: CommonUIError = CommonUIError(id: 0, message: "Something went wrong")
}

extension Error {
    func asCommonUIError() -> CommonUIError {
        guard let networkError = self as? NetworkError else {
            return CommonUIError.somethingWhenWrong
        }
        
        switch networkError {
        case .invalidRequest(let error),
                .invalidResponse(let error),
                .other(let error):
            return CommonUIError(id: (error as NSError).code,
                                 message: error.localizedDescription)
        case .invalidJSON:
            return CommonUIError.somethingWhenWrong
        }
    }
}

