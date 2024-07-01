//
//  AppStateUseCase.swift
//
//  Use Case for Global Application Functionality
//


import Foundation
import swiftarcstdlib

class AppStateUseCase: UseCase {
    typealias State = AppState
    var lens: StateAccess {
        \.app
    }
    var useCaseBridge: UseCaseBridge?

    let stateController: GlobalStateController

    private var appVersion: String {
        do {
            return try Configuration.versionString
        } catch {
            internalError(with: error)
        }

        return "N/A"
    }

    private var configName: String {
        do {
            return try Configuration.configName
        } catch {
            internalError(with: error)
        }

        return "N/A"
    }

    required init(
        stateController: GlobalStateController,
        dependencies: Dependencies = .dependencies
    ) {
        self.stateController = stateController
        Logger.info(topic: .usecase, message: "App State initialising")
        Logger.info(topic: .usecase, message: "- Version : \(appVersion)")
        Logger.info(topic: .usecase, message: "- Configuration : \(configName)")
    }
}


// MARK: Dependencies Extension

extension AppStateUseCase {
    struct Dependencies: DependencyConformance {
        static var dependencies: Dependencies = .init()
    }
}

