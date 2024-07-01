//
//  NavigationFlow.swift
//

import SwiftUI

protocol NavigationFlow<FlowElement>: IteratorProtocol where FlowElement == Element {
    associatedtype FlowElement: PathView
    associatedtype Control: NavigationControl

    var current: Self.FlowElement { get }
}
