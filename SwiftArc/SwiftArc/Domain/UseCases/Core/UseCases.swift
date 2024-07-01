//
//  UseCases.swift
//

import Foundation

class UseCases {
    static let shared: UseCases = {
        UseCases()
    }()


    private let useCaseContainer = UseCaseContainer()
    private var stateController: GlobalStateController? = nil

    func configure(withStateController stateController: GlobalStateController) {
        registerUseCase(instance: AppStateUseCase(stateController: stateController))

        self.stateController = stateController
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
        let useCases = UseCases()
        useCases.configure(withStateController: stateController)
        return useCases
    }
}
