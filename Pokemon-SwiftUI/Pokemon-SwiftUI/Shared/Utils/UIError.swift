//
//  UIError.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 14/05/2022.
//

import Foundation

struct UIError: Identifiable {
    let id: Int
    let messages: String
}

extension UIError: Error {
}
