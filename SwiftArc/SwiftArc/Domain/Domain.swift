//
//  Domain.swift
//

import Foundation
import Combine

class Domain {
    static let shared: Domain = {
        Domain()
    }()

    let stateController: GlobalStateController
    let useCases: UseCases

    init(
        dependencies: Dependencies = .shared
    ) {
        DomainKey.initialise()
        self.stateController = dependencies.state
        self.useCases = dependencies.useCases

        useCases.configure(withStateController: stateController)
    }

    func useCase<T: UseCase>(_ type: T.Type) -> T {
        do {
            return try useCases.useCase(type)
        } catch {
            // Unable to continue if a usecase is not
            fatalError("Underlying error with use cases: \(error)")
        }
    }

    static var previewState: GlobalState {
        get {
            Self.shared.stateController.state
        }

        set {
            Self.shared.stateController.state = newValue
        }
    }
}

extension Domain {
    struct Dependencies {
        let state: GlobalStateController
        let useCases: UseCases

        static var shared: Dependencies {
            Dependencies(
                state: GlobalStateController.shared,
                useCases: UseCases.shared
            )
        }
    }
}



