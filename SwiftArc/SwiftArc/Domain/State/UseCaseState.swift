//
//  UseCaseState.swift
//

import Foundation

typealias Stateable = Sendable & Hashable & Equatable

protocol UseCaseState: Stateable {}
