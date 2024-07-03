//
//  UseCaseState.swift
//

import Foundation

typealias Stateable = Hashable & Equatable

protocol UseCaseState: Stateable {}
