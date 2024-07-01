//
//  NavigationControl.swift
//

import Foundation
import swiftarcstdlib

typealias PathView = Hashable & Equatable

protocol NavigationControl: AnyObject {
    associatedtype PathType: PathView

    var navigationPath: [PathType] { get set }
    var navigationFlow: (any NavigationFlow<PathType>)? { get set }

    // Direct functions used to manage the view currently displayed
    func popToRoot()
    func pop(from view: PathType)
    func push(view: PathType)

    // Functions which use to manage a direct flow within the navigation control
    func start(flow: any NavigationFlow<PathType>)
    func progressCurrentFlow(defaultNoFlow view: PathType)
    func endCurrentFlow()
    func isInNavigationFlow() -> Bool
}

extension NavigationControl {
    func start(flow: any NavigationFlow<PathType>) {
        Logger.info(topic: .appState, message: "Navigation - Starting Flow -> \(flow)")
        navigationFlow = flow
        push(view: flow.current)
    }

    func progressCurrentFlow(defaultNoFlow view: PathType) {
        Logger.info(topic: .appState, message: "Navigation - Progress Current Flow")
        guard isInNavigationFlow(), let next = navigationFlow?.next() else {
            endCurrentFlow()
            push(view: view)
            Logger.info(topic: .appState, message: "Navigation - Flow finished or no flow exists, defaulting to view : \(view)")
            return
        }

        push(view: next)
    }

    func endCurrentFlow() {
        Logger.info(topic: .appState, message: "Navigation - End Current Flow")
        navigationFlow = nil
    }

    func isInNavigationFlow() -> Bool {
        return navigationFlow != nil
    }
}
