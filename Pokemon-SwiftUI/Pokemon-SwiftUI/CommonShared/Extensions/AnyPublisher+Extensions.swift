//
//  AnyPublisher+Extensions.swift
//  Pokemon-SwiftUI
//
//  Created by Son Hoang on 09/05/2022.
//

import Combine

extension Publisher {
    func mapToVoid() -> AnyPublisher<Void, Failure> {
        return self.map { _ in return () }.eraseToAnyPublisher()
    }

    func unwrapOrFail<Wrapped>(with error: Failure) -> Publishers.FlatMap<Result<Wrapped, Self.Failure>.Publisher, Self> where Output == Wrapped? {
        return self.flatMap({ $0.map { Result.success($0).publisher } ?? Result.failure(error).publisher })
    }
}

extension AnyPublisher {
    static func empty() -> AnyPublisher<Output, Failure> {
        return Empty(completeImmediately: false)
            .eraseToAnyPublisher()
    }
    
    static func emptyAndCompleted() -> AnyPublisher<Output, Failure> {
        return Empty(completeImmediately: true)
            .eraseToAnyPublisher()
    }
    
    static func just(_ output: Output) -> AnyPublisher<Output, Failure> {
        return Just(output)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
    
    static func fail(_ error: Failure) -> AnyPublisher<Output, Failure> {
        return Fail(error: error)
            .eraseToAnyPublisher()
    }
}
