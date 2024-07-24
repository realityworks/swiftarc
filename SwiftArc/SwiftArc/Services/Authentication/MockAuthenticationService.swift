//
//  MockAuthenticationService.swift
//

// SAMPLE MOCK AUTHENTATION SERVICE

import swiftarcstdlib
import Foundation

class MockAuthenticationService: AuthenticationService {
    private struct UserAccountEntry: Codable {
        var user: ActiveUser
        var password: String
        
        init(user: ActiveUser, password: String) {
            self.user = user
            self.password = password
        }
    }
    
    private var allUsers: [UserAccountEntry]
    
    init() {
        allUsers = Self.readAllUsers()
    }
    
    func login(with userName: String, _ password: String) async throws -> ActiveUser {
        try await Task.sleep(forSeconds: 2)

        let userData = allUsers.first(
            where: {
                $0.user.email == userName && $0.password == password
            }
        )
        
        guard let userData else {
            throw AuthenticationError.credentialsInvalid
        }

        let activeUser = userData.user
        
        Self.write(activeUser: activeUser)
        return activeUser
    }

    func logout() throws {
        // Delete active user
        UserDefaults.standard.removeObject(forKey: Self.activeUserKey())
    }

    func signup(with userName: String, _ name: String, _ password: String) async throws -> ActiveUser {
        // Test case for failure during signup
        guard UserDefaults.standard.data(forKey: Self.activeUserKey()) == nil else {
            throw AuthenticationError.unhandledError(error: "Attepting to sign up while already logged in")
        }

        guard allUsers.contains(where: {$0.user.email == userName}) == false else {
            throw AuthenticationError.accountFailedCreating
        }
        
        try await Task.sleep(forSeconds: 2)

        let activeUser = ActiveUser(name: name, email: userName)
        Self.write(activeUser: activeUser)

        allUsers.append(.init(user: activeUser, password: password))
        Self.write(allUsers: allUsers)
        
        return activeUser
    }

    private static func activeUserKey() -> String {
        "authActiveUser"
    }

    private static func write(allUsers: [UserAccountEntry]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(allUsers)

            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: "allUsers")
        } catch {
            Logger.error(topic: .authentication, message: "Cannot write MOCK allUsers - \(error)")
        }
    }
    
    private static func readAllUsers() -> [UserAccountEntry] {
        do {
            guard let data = UserDefaults.standard.data(forKey: "allUsers") else {
                throw "No allUsers data is available..."
            }

            // Convert to data type
            let decoder = JSONDecoder()
            let value = try decoder.decode([UserAccountEntry].self, from: data)
            return value
        } catch {
            Logger.error(topic: .authentication, message: "Cannot read MOCK  allUsers - \(error)")
            return []
        }
    }
    
    private static func write(activeUser: ActiveUser) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(activeUser)

            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: Self.activeUserKey())
        } catch {
            Logger.error(topic: .authentication, message: "Cannot write MOCK active user - \(error)")
        }
    }

    private static func readActiveUser() -> ActiveUser? {
        do {
            guard let data = UserDefaults.standard.data(forKey: Self.activeUserKey()) else {
                throw "No active user is available..."
            }

            // Convert to data type
            let decoder = JSONDecoder()
            let value = try decoder.decode(ActiveUser.self, from: data)
            return value
        } catch {
            Logger.error(topic: .authentication, message: "Cannot read MOCK active user - \(error)")
            return nil
        }
    }

    func delete(user userName: String, _ password: String) async throws {
        do {
            guard UserDefaults.standard.value(forKey: Self.activeUserKey()) != nil else {
                throw "User data does not exists :\(Self.activeUserKey())"
            }

            let userExists = allUsers.contains(
                where: {
                    $0.user.email == userName && $0.password == password
                }
            )
            
            guard userExists else {
                throw "Invalid Credentials"
            }
            
            allUsers.removeAll(where: {$0.user.email == userName})
            Self.write(allUsers: allUsers)
        } catch {
            Logger.error(topic: .authentication, message: "Cannot read MOCK active user - \(error)")
            throw "Failed deleting user data: \(error)"
        }
    }
    
    func changePassword(
        for userName: String,
        from oldUserName: String,
        to newUserName: String
    ) async throws {
        try? await Task.sleep(forSeconds: 2)
    }

    func resetPasswordRequest(for userName: String) async throws {
        try await Task.sleep(forSeconds: 1)
    }
}
