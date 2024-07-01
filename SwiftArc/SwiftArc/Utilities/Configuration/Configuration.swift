//
//  Configuration.swift
//

import swiftarcstdlib
import Foundation

//

enum ConfigurationError: LocalizedError {
    case debuUIUnavailable
    case useMockUnavailable

    var errorDescription: String? {
        switch self {
        case .debuUIUnavailable:
            return "DebugUI is not available."
        case .useMockUnavailable:
            return "Mock Version is not available."
        }
    }
}

extension Configuration {
    static var versionString: String {
        get throws { try value(for: .versionString, as: String.self) }
    }
    
    static var buildString: String {
        get throws { try value(for: .buildString, as: String.self) }
    }

    static var configName: String {
        get throws { try value(for: .configName, as: String.self) }
    }

    static var apiServiceURL: URL {
        get throws { try url(for: .apiServiceURL) }
    }

    static var debugUIEnabled: Bool {
        get throws {
            guard let value = Bool(try value(for: .debugUIEnabled, as: String.self)) else {
                Logger.warning(topic: .usecase, message: "Debug UI not enabled in the current configuration...")
                throw ConfigurationError.debuUIUnavailable
            }

            return value
        }
    }

    static var useMock: Bool {
        get throws {
            guard let value = Bool(try value(for: .useMock, as: String.self)) else {
                Logger.warning(topic: .usecase, message: "Use Mock not set in the current configuration...")
                throw ConfigurationError.useMockUnavailable
            }

            return value
        }
    }

    static var siteURL: URL {
        get throws { try url(for: .siteURL) }
    }

    /// Utility function that builds a URL and initial query for ios
    private static func siteLinkURL(atPath: String) throws -> URL {
        try Self.siteURL.appendingPathComponent(atPath)
    }
}

// MARK: Internal only
private enum ConfigKey: String, CaseIterable {
    case versionString = "CFBundleShortVersionString"
    case buildString = "CFBundleVersion"
    case apiServiceURL = "SERVICE_ROOT_URL"
    case siteURL = "SITE_ROOT_URL"
    case debugUIEnabled = "DEBUG_UI_ENABLED"
    case useMock = "USE_MOCK"
    case configName = "CONFIG_NAME"
}

class Configuration {

    private enum Error: Swift.Error {
        case invalidValueType(String)
        case invalidKey(String)
        case arrayTypesMismatch

        var localizedDescription: String {
            switch self {
            case .invalidValueType(let details):
                return "Invalid Value Type: \(details)"
            case .invalidKey(let details):
                return "Invalid Key: \(details)"
            case .arrayTypesMismatch:
                return "Array does not have a compelte set of matching types."
            }
        }
    }

    private static var appDictionary: [String: Any] = {
        guard let dictionary = Bundle.main.infoDictionary else {
            Logger.error(topic: .appState, message: "No infoDictionary exists in app bundle!")
            return [:]
        }
        return dictionary
    }()

    private static func array<T>(for key: ConfigKey) throws -> [T] {
        let array = try value(for: key, as: [Any].self)
        let castedArray = array.compactMap { $0 as? T }

        guard array.count == castedArray.count else {
            throw Error.arrayTypesMismatch
        }

        return castedArray
    }

    private static func value<T>(for key: ConfigKey, as _: T.Type) throws -> T {
        guard let anyValue = appDictionary[key.rawValue] else {
            throw Error.invalidKey(key.rawValue)
        }
        guard let castedValue = anyValue as? T else {
            throw Error.invalidValueType(String(describing: T.self))
        }
        return castedValue
    }

    private static func url(for key: ConfigKey) throws -> URL {
        guard let anyValue = appDictionary[key.rawValue] else {
            throw Error.invalidKey(key.rawValue)
        }
        guard let castedValue = anyValue as? String, let url = URL(string: castedValue) else {
            throw Error.invalidValueType(String(describing: String.self))
        }
        return url
    }
}
