//
//  DomainError.swift
//

import Foundation

// Any error mapped by the domain that has been generated and
// will be passed through the error management funnel.

struct DomainError: LocalizedError {
    let title: String
    let originalError: Error
    let dateTime: Date

    let primaryAction: DomainErrorAction
    let secondaryAction: DomainErrorAction?

    //
    // Simple initializer with error
    //
    
    init(
        with error: Error
    ) {
        self.title = "Unexecpected Error"
        self.originalError = error
        self.dateTime = .now
        self.primaryAction = .ok
        self.secondaryAction = nil
    }

    //
    // Complete intializer with some default parameters set
    //

    init(
        title: String,
        error: Error,
        dateTime: Date = .now,
        primaryAction: DomainErrorAction = .ok,
        secondaryAction: DomainErrorAction? = nil
    ) {
        self.title = title
        self.originalError = error
        self.dateTime = dateTime
        self.primaryAction = primaryAction
        self.secondaryAction = secondaryAction
    }


    var errorDescription: String? {
        switch originalError {
        case let error as LocalizedError:
            return error.errorDescription
        default:
            return originalError.localizedDescription
        }

    }
}

extension DomainError {
    static func unexpected(_ error: Error) -> DomainError {
        DomainError(with: error)
    }

}
