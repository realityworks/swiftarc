//
//  DomainPersistenceKeys.swift
//

import Foundation
import SwiftUI

// Simplified class for the domain to manage its peristence keys

enum DomainKey {
    //ie - case user(userId: String)

    func value<T: Storable>() throws -> T {
        do {
            return try Self.dependencies.persistenceService.read(from: self.key)
        } catch {
            throw "Value of type \(String(describing: T.self)) failed to read for key \(self.key) with error: \(error)"
        }
    }

    func remove() throws {
        do {
            try Self.dependencies.persistenceService.remove(key: self.key)
        } catch {
            throw "Failed to remove value for key \(self.key) with error: \(error)"
        }
    }

    func write<T: Storable>(_ value: T) throws {
        do {
            try Self.dependencies.persistenceService.write(value: value, key: self.key)
        } catch {
            throw "Failed to write value of type \(String(describing: T.self)) for key \(self.key) with error: \(error)"
        }
    }

    func exists() -> Bool {
        Self.dependencies.persistenceService.contains(valueFor: self.key)
    }

    var key: String {
//        switch self {
//        case let .user(userId):
//            return "user_\(String(describing: userId))".lowercased()
//        }
        return String()
    }
}

// MARK: Manage dependencies

extension DomainKey {

    // This allows us to privately initialise the DomainKey. It also
    // provides runtime dependency change support.
    private static var instanceDependencies: Dependencies? = nil
    private static var dependencies: Dependencies {
        guard let dependencies = instanceDependencies else {
            // Default to Mock
            return .mock
        }

        return dependencies
    }

    struct Dependencies {
        let persistenceService: PersistenceService

        static let live = {
            Dependencies(
                persistenceService: ServicesProvider.persistenceService
            )
        }()

        static let mock = {
            Dependencies(
                persistenceService: ServicesProvider.persistenceService
            )
        }()
    }

    static func initialise(dependencies: Dependencies = .mock) {
        Self.instanceDependencies = dependencies
    }
}
