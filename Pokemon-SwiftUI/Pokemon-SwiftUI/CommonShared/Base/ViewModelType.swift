//
//  ViewModelType.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 12/05/2022.
//

import Foundation

protocol ViewModelType {
    func setupViewModel()
    
    func onAppear()
    func onDisappear()
}

extension ViewModelType {
    func setupViewModel() {}
    
    func onAppear() {}
    func onDisappear() {}
}
