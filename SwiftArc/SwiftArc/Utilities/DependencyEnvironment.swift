//
//  DependencyEnvironment.swift
//

import Foundation

protocol DependencyEnvironment {
    associatedtype DI: DependencyConformance

    init(stateController: GlobalStateController, dependencies: DI)
}

protocol DependencyConformance {
    static var dependencies: Self { get }
}
