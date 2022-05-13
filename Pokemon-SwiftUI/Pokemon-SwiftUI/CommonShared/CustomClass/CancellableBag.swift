//
//  CancellableBag.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 09/05/2022.
//

import Combine

class CancellableBag {
    var cancellables = Set<AnyCancellable>()
    
    func insert(_ anyCancellable: AnyCancellable) {
        anyCancellable.store(in: &cancellables)
    }
    
    func insert(_ anyCancellables: [AnyCancellable]) {
        anyCancellables.forEach { anyCancellable in
            anyCancellable.store(in: &cancellables)
        }
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
    }
}
