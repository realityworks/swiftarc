//
//  DomainErrorAction.swift
//

import Foundation

struct DomainErrorAction {
    static let ok = Self.init(handlerType: .ok)
    static let `continue` = Self.init(handlerType: .continue)
    static let cancel = Self.init(handlerType: .cancel)

    typealias Handler = ()->()

    enum HandlerType {
        case ok
        case `continue`
        case cancel
        case custom(text: String)

        // TODO: Move these to localizable.strings

        var title: String {
            switch self {
            case .ok:
                return "Ok"
            case .continue:
                return "Continue"
            case .cancel:
                return "Cancel"
            case let .custom(text):
                return text
            }
        }

    }

    let handlerType: HandlerType
    let handler: Handler?

    init(handlerType: HandlerType, handler: Handler? = nil) {
        self.handlerType = handlerType
        self.handler = handler
    }
}
