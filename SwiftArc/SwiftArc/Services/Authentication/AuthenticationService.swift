//
//  AuthenticationService.swift
//

import Foundation

protocol AuthenticationService {
    // User state management
    func login(with userName: String, _ password: String) async throws -> ActiveUser
    func logout() throws
    func signup(with userName: String, _ name: String, _ password: String) async throws -> ActiveUser
    func delete(user userName: String, _ password: String) async throws

    // Credentials management
    func changePassword(for userName: String, from oldPassword: String, to newPassword: String) async throws
    func resetPasswordRequest(for userName: String) async throws
}
