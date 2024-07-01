//
//  UseCase.swift
//

import swiftarcstdlib
import Foundation

// A use case requires it to have access to a global state controller...
protocol UseCase: AnyObject, CustomStringConvertible, DependencyEnvironment {
    associatedtype State: UseCaseState
    typealias StateAccess = WritableKeyPath<GlobalState, State>

    var stateController: GlobalStateController { get }
    var useCaseBridge: UseCaseBridge? { get set }
    var lens: StateAccess { get }
    var state: State { get set }
}

extension UseCase {
    var description: String {
        "\(String(describing: type(of: self)))"
    }
}

extension UseCase {
    var globalState: GlobalState {
        set {
            stateController.state = newValue
        }

        get {
            stateController.state
        }
    }

    var state: State {
        get {
            globalState[keyPath: lens]
        } set {
            globalState[keyPath: lens] = newValue
        }
    }

    func localPublisher<T: Equatable>(_ keyPath: KeyPath<State, T>) -> SafePublisher<T> {
        let stateKeyPath = lens
        let childKeyPath = stateKeyPath.appending(path: keyPath)
        return stateController.publisher(for: childKeyPath)
            .eraseToAnyPublisher()
    }

    func internalError(with error: Error) {
        Logger.error(topic: .appState, message: "Internal Error: \(error.localizedDescription)")

        guard let domainError = error as? DomainError else {
            stateController.errorSubject.send(.unexpected(error))
            return
        }

        Logger.error(topic: .appState, message: "Domain Error: \(domainError.title)")
        stateController.errorSubject.send(domainError)
    }

    func alert(_ domainAlert: DomainAlert) {
        Logger.info(topic: .appState, message: "Alert: \(domainAlert.message)")
        stateController.alertSubject.send(domainAlert)
    }

    func removeShownAlerts() {
        Logger.info(topic: .appState, message: "Removing all visible alerts")
        stateController.clearAllAlerts.send(())
    }
}
