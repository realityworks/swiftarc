//
//  GlobalStateController.swift
//

import Foundation
import Combine

class GlobalStateController {
    static let shared: GlobalStateController = {
        GlobalStateController()
    }()

    let stateLock = NSLock()

    fileprivate var unsafeState: GlobalState = .init()
    var state: GlobalState {
        set {
            // perform writes on data synchronously to keep the data thread safe
            stateLock.withLock {
                self.unsafeState = newValue
            }

            DispatchQueue.main.async {
                self.stateSubject
                    .send(newValue)
            }
        }

        get {
            let safeState: GlobalState

            stateLock.lock()
            safeState = unsafeState
            stateLock.unlock()

            return safeState
        }
    }

    private let stateSubject: CurrentValueSubject<GlobalState, Never>
    let errorSubject: PassthroughSubject<DomainError, Never>
    let alertSubject: PassthroughSubject<DomainAlert, Never>
    let clearAllAlerts: PassthroughSubject<(), Never>

    private init() {
        stateSubject = .init(unsafeState)
        errorSubject = .init()
        alertSubject = .init()
        clearAllAlerts = .init()
    }

    private func statePublisher() -> AnyPublisher<GlobalState, Never> {
        stateSubject
            .eraseToAnyPublisher()
    }

    func publisher<T: Equatable>(
        for keyPath: KeyPath<GlobalState, T>,
        distinct: Bool = true
    ) -> AnyPublisher<T, Never> {
        let publisher = statePublisher()
            .map(keyPath)

        if distinct {
            return publisher
                .removeDuplicates()
                .eraseToAnyPublisher()
        }

        return publisher
            .eraseToAnyPublisher()
    }


    func compactPublisher<T: Equatable>(
        for keyPath: KeyPath<GlobalState, Optional<T>>,
        distinct: Bool = true
    ) -> AnyPublisher<T, Never> {
        publisher(for: keyPath, distinct: distinct)
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
}
