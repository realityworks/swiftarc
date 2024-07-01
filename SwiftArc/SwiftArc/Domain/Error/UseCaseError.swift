//
//  UseCaseErrors.swift
//

import Foundation

enum UseCaseError: LocalizedError {
    case invalidUseCase
    case noUseCaseBridge

    var errorDescription: String? {
        switch self {
        case .invalidUseCase: return "Invalid use case"
        case .noUseCaseBridge: return "No use case bridge available"
        }
    }
}
