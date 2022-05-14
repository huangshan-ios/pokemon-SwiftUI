//
//  Array+Extensions.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 14/05/2022.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return self.indices ~= index ? self[index] : nil
    }
}
