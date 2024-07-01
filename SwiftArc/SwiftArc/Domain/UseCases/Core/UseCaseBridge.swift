//
//  UseCaseBridge.swift
//

import Foundation

/// Use case bridge protocol defines a way to access use cases from any point in the Domain layer. The source of the use case is not important.
protocol UseCaseBridge {
    /// This function will return a use case for the type requested, given the bridge has access to it.
    /// - parameter type: A class the conforms to the use case protocol, or nil if none is available.
    func resolve<T: UseCase>(_ type: T.Type) -> T?
}
