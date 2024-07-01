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
        self.useCases = UseCases.instance(forStateController: dependencies.state)
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

        static var shared: Dependencies {
            Dependencies(
                state: GlobalStateController.shared
            )
        }
    }
}



