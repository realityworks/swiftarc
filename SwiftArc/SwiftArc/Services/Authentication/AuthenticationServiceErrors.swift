//
//  AuthenticationServiceErrors.swift
//

import Foundation

enum AuthenticationError: LocalizedError {
    case unhandledError(error: Error)
    case serviceNotConfigured
    case accountFailedCreating
    case credentialsInvalid
    case accountDisabled
    case accountDetailsMissing
    case userDataNotAvailable

    var errorDescription: String? {
        switch self {
        case let .unhandledError(error): return "We ran into an unexpected error. Please try again later. If the error continues, contact support with : \(error.localizedDescription)"
        case .accountDetailsMissing: return "The account does not exist. Please contact support."
        case .serviceNotConfigured: return "The authentication service is unavailable at this time. Please try reinstalling the app"
        case .accountFailedCreating: return "The account could not be correctly created. Please contact support."
        case .credentialsInvalid: return "Credentials are invalid"
        case .accountDisabled: return "Your account has been disabled. Please contact support."
        case .userDataNotAvailable: return "We could not load your user data. Please try reinstalling the app."
        }
    }
}
