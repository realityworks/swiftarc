//
//  String+Extensions.swift
//

import Foundation

// Easily convert strings into errors

extension String: LocalizedError {
    public var errorDescription: String? {
        return self
    }
}

// Validation

extension String {
    public var isEmailAddress: Bool {
        let ranges = self.ranges(of: /^\S+@\S+\.\S+$/)
        return !ranges.isEmpty
    }
    // 8 or more characters
    // atleast one uppercase characters
    // atleast one number
    public var isValidPassword: Bool {
        let ranges = self.ranges(of: /^([\S ]){6,}$/)
        return !ranges.isEmpty
    }
}
