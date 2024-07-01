//
//  LivePersistenceService.swift
//

import swiftarcstdlib
import Foundation

class LivePersistenceService: PersistenceService {
    typealias Key = String

    func write<T: Storable>(value: T, key: Key) throws {
        let encoder = JSONEncoder()
        let jsonValue = try encoder.encode(value)
        //Logger.verbose(topic: .other, message: "Writing: \(String(describing: value.self)) with key \(key)")
        UserDefaults.standard.setValue(jsonValue, forKey: key)
    }

    func read<T: Storable>(from key: Key) throws -> T {
        guard let jsonValue = UserDefaults.standard.value(forKey: key) as? Data else {
            throw PersistenceServiceErrors.valueForKeyDoesNotExist
        }

        //Logger.verbose(topic: .other, message: "Reading: \(String(describing: T.self)) with key \(key)")
        let decoder = JSONDecoder()
        let value = try decoder.decode(T.self, from: jsonValue)

        return value
    }

    func remove(key: Key) throws {
        guard contains(valueFor: key) else {
            throw PersistenceServiceErrors.valueForKeyDoesNotExist
        }

        UserDefaults.standard.removeObject(forKey: key)
    }

    func contains(valueFor key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
