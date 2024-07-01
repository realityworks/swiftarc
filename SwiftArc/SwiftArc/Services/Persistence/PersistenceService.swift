//
//  PersistenceService.swift
//

import Foundation

// Protocol for secure and insecure persistence of data on the phone.
// Persistence should be thread safe.
protocol PersistenceService {
    typealias Key = String
    
    func write<T: Storable>(value: T, key: Key) throws
    func read<T: Storable>(from key: Key) throws -> T
    func remove(key: Key) throws
    func contains(valueFor key: Key) -> Bool
}
