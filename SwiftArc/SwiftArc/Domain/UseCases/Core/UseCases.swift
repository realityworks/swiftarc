//
//  UseCases.swift
//

import Foundation

class UseCases {

    private let useCaseContainer = UseCaseContainer()
    private let stateController: GlobalStateController

    init(stateController: GlobalStateController) {
        // Initialise with live for main use environment
        self.stateController = stateController
    }

    func configure() {
        registerUseCase(instance: AppStateUseCase(stateController: stateController))
    }

    func registerUseCase<T: UseCase>(instance: T) {
        let type = type(of: instance)
        instance.useCaseBridge = useCaseContainer
        useCaseContainer.register(useCase: type, instance: instance)
    }

    func useCase<T: UseCase>(_ type: T.Type) throws -> T {
        guard let useCase = useCaseContainer.resolve(type) else {
            throw UseCaseError.invalidUseCase
        }

        return useCase
    }
}

extension UseCases {
    static func instance(forStateController stateController: GlobalStateController) -> UseCases {
        let useCases = UseCases(stateController: stateController)
        useCases.configure()
        return useCases
    }
}
