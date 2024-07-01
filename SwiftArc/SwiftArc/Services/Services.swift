//
//  ServicesProvider.swift
//

import Foundation

class ServicesProvider {

    private let authenticationService: AuthenticationService
    private let persistenceService: PersistenceService
    private let userNotificationService: UserNotificationService

    required init(
        authenticationService: AuthenticationService,
        persistenceService: PersistenceService,
        userNotificationService: UserNotificationService
    ) {
        self.authenticationService = authenticationService
        self.persistenceService = persistenceService
        self.userNotificationService = userNotificationService
    }
}

extension ServicesProvider {
    static var live: ServicesProvider = ServicesProvider(
        authenticationService: LiveAuthenticationService(),
        persistenceService: LivePersistenceService(),
        userNotificationService: LiveUserNotificationService()
    )

    static var mock: ServicesProvider = ServicesProvider(
        authenticationService: MockAuthenticationService(),
        persistenceService: MockPersistenceService(),
        userNotificationService: LiveUserNotificationService()
    )
}

extension ServicesProvider {
    static var authenticationService: AuthenticationService {
        let useMock = (try? Configuration.useMock) ?? true
        if useMock {
            return Self.mock.authenticationService
        }

        return Self.live.authenticationService
    }

    static var persistenceService: PersistenceService {
        let useMock = (try? Configuration.useMock) ?? true
        if useMock {
            return Self.mock.persistenceService
        }

        return Self.live.persistenceService
    }

    static var userNotificationService: UserNotificationService  {
        let useMock = (try? Configuration.useMock) ?? true
        if useMock {
            return Self.mock.userNotificationService
        }

        return Self.live.userNotificationService
    }
}
