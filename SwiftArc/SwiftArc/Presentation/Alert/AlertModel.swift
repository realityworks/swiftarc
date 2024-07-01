//
//  AlertModel.swift
//

import Foundation

struct AlertModel {
    enum Style {
        case clearAll
        case blockingModal
        case timedToast(TimeInterval)
        case blockingToast
    }
    
    enum Indication {
        case error
        case notification
    }

    struct Action {
        enum Style {
            case primary
            case secondary
        }

        let title: String
        let handler: (()->())
        let style: Style
    }

    var presentedTitle: String {
        title ?? "Alert"
    }
    private var title: String? = nil
    var message: String
    var style: Style
    var indication: Indication
    var actions: [Action]

    static var defaultPrimaryAction: Action = .init(title: "Continue", handler: { /* Do nothing */}, style: .primary)

    init(
        title: String? = nil,
        message: String,
        style: Style,
        indication: Indication,
        actions: [Action]
    ) {
        self.title = title
        self.message = message
        self.style = style
        self.indication = indication
        self.actions = actions
    }

    init(_ domainAlert: DomainAlert) {
        self.message = domainAlert.message

        self.style = AlertModel.style(from: domainAlert.style)
        self.indication = AlertModel.indication(from: domainAlert.style)

        // Configure the actions
        switch domainAlert.style {
        case let .confirm(cancelAction, confirmAction):
            self.actions = [
                .init(title: "Cancel", handler: cancelAction, style: .secondary),
                .init(title: "Confirm", handler: confirmAction, style: .primary)
            ]
        case let .result(confirmAction: confirmAction):
            self.actions = [
                .init(title: "Confirm", handler: confirmAction, style: .primary)
            ]
        default:
            self.actions = []
        }
    }

    init(_ domainError: DomainError) {
        self.title = domainError.title
        self.message = domainError.errorDescription ?? "Unexpected Error"
        self.style = .blockingModal
        self.indication = .error

        var actions: [Action] = [
            .init(
                title: domainError.primaryAction.handlerType.title,
                handler: domainError.primaryAction.handler ?? { },
                style: .primary
            )
        ]

        if let secondaryDomainAction = domainError.secondaryAction {
            actions.append(
                .init(
                    title: secondaryDomainAction.handlerType.title,
                    handler: secondaryDomainAction.handler ?? { },
                    style: .secondary
                )
            )
        }

        self.actions = actions
    }

    private static func style(from domainAlertStyle: DomainAlert.Style) -> Style {
        switch domainAlertStyle {
        case .errorToast:
            return .blockingToast
        case let .notificationToast(timeInterval):
            if let timeInterval {
                return .timedToast(timeInterval)
            } else {
                return .blockingToast
            }
        case .confirm, .result:
            return .blockingModal
        }
    }
    
    private static func indication(from domainAlertStyle: DomainAlert.Style) -> Indication {
        switch domainAlertStyle {
        case .errorToast:
            return .error
        case .notificationToast:
            return .notification
        case .confirm, .result:
            return .notification
        }
    }

    static func blocking(
        withTitle title: String,
        message: String,
        actions: [Action] = []
    ) -> AlertModel {
        let actions: [Action] = actions
        return .init(
            title: title,
            message: message,
            style: .blockingModal,
            indication: .notification,
            actions: actions
        )
    }

    static func timedToast(
        withMessage message: String,
        interval: TimeInterval
    ) -> AlertModel {
        return .init(
            message: message,
            style: .timedToast(interval),
            indication: .notification,
            actions: []
        )
    }

    static func blockingToast(
        withMessage message: String
    ) -> AlertModel {
        return .init(message: message, style: .blockingToast, indication: .error, actions: [])
    }

    static func clearAllAlerts() -> AlertModel {
        return .init(
            message: "",
            style: .clearAll,
            indication: .notification,
            actions: []
        )
    }
}
