//
//  DomainAlert.swift
//

import Foundation

struct DomainAlert {
    typealias AlertAction = ()->()

    enum Style {
        case errorToast
        case notificationToast(TimeInterval?)
        case result(confirmAction: AlertAction)
        case confirm(cancelAction: AlertAction, confirmAction: AlertAction)

        static var notificationToast: Self {
            return .notificationToast(nil)
        }
    }

    var message: String
    var style: Style
}
