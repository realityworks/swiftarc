//
//  AlertOverlay.swift
//

import SwiftUI
import Combine

struct AlertOverlay<Content: View>: View {
    var content: Content
    @ObservedObject var manager: AlertOverlayManager

    init(
        _ manager: AlertOverlayManager,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.manager = manager
        self.content = content()
    }

    var body: some View {
        ZStack {
            content.blur(
                radius: manager.showingAlert
                    ? Constants.UserInterfaceDefaults.blurRadius
                    : 0
            )

            // Show a toast alert if the current settings are to show the alert as a toast
            if manager.showingToast, let alert = manager.currentAlertModel {
                VStack {
                    Spacer()
                    ToastView(
                        alert: alert,
                        dismissAction: { manager.dismiss() }
                    )
                        .padding()
                }
            }
        }
        .alert(isPresented: $manager.showingAlert) {
            guard let alertModel = manager.currentAlertModel else {
                return Alert(title: Text("Unexected internal error as occured."))
            }

            // Support only one of each
            let primaryAction = alertModel.actions.first(where: { $0.style == .primary }) ??
                AlertModel.defaultPrimaryAction
            let secondaryAction = alertModel.actions.first(where: { $0.style == .secondary })

            let primaryButton = Alert.Button.default(Text(primaryAction.title)) {
                primaryAction.handler()
                self.manager.dismiss()
            }

            let titleText = Text(alertModel.presentedTitle)
                .font(.title)

            // Select the alert type based on the number of actions
            let alert: Alert
            if let secondaryAction {
                let textView = Text(secondaryAction.title)
                let secondaryButton = Alert.Button.default(textView) {
                    secondaryAction.handler()
                    self.manager.dismiss()
                }
                alert = Alert(
                    title: titleText,
                    message: Text(alertModel.message),
                    primaryButton: primaryButton,
                    secondaryButton: secondaryButton
                )
            } else {
                alert = Alert(
                    title: titleText,
                    message: Text(alertModel.message),
                    dismissButton: primaryButton
                )
            }

            return alert
        }
    }
}

struct AlertOverlay_Previews: PreviewProvider {
    static let publisher = PassthroughSubject<AlertModel, Never>()
    static var internalView: some View {
        VStack {
            Spacer()
            Group {
                Text("Some Test Text")
                Text("Some Test Text")
                Text("Some Test Text")
            }
            Spacer()
            Group {
                Text("Some Test Text")
                Text("Some Test Text")
                Text("Some Test Text")
            }
            Spacer()
            Group {
                Text("Some Test Text")
                Text("Some Test Text")
                Text("Some Test Text")
            }
            //Spacer()
        }
    }

    static var previews: some View {
        let manager = AlertOverlayManager(
            alertState: publisher.eraseToAnyPublisher()
        )

        // Alert Test
        AlertOverlay(
            manager
        ) {
            internalView
        }
        .task {
            let firstState = AlertModel.blocking(withTitle: "First!", message: "Warning!")
            publisher.send(firstState)
            try? await Task.sleep(forSeconds: 2)

            let delayedState = AlertModel.blocking(withTitle: "Delayed Number 1", message: "With message...")
            publisher.send(delayedState)
            try? await Task.sleep(forSeconds: 2)

            let actionState = AlertModel.blocking(
                withTitle: "Delayed Options Number 2",
                message: "With message...",
                actions: [
                    .init(title: "Ok", handler: { /* do nothing */ }, style: .primary),
                    .init(title: "Cancel", handler: { /* do nothing */ }, style: .secondary)
                ]
            )
            publisher.send(actionState)
            try? await Task.sleep(forSeconds: 2)

            let blockingToastState = AlertModel.blockingToast(withMessage: "Blocking toast")
            publisher.send(blockingToastState)
            try? await Task.sleep(forSeconds: 2)

            let nonBlockingToastState = AlertModel.timedToast(
                withMessage: "Non-Blocking toast",
                interval: 4
            )
            publisher.send(nonBlockingToastState)
            try? await Task.sleep(forSeconds: 2)

            let blockingState = AlertModel.blocking(
                withTitle: "Delayed Options Number 3",
                message: "With message...",
                actions: [
                    .init(title: "Ok", handler: { /* do nothing */ }, style: .primary),
                    .init(title: "Cancel", handler: { /* do nothing */ }, style: .secondary)
                ]
            )
            publisher.send(blockingState)
        }

        // Toast Test
        AlertOverlay(
            manager
        ) {
            internalView
        }
        .task {
            let firstState = AlertModel.blockingToast(withMessage: "Blocking 1")
            publisher.send(firstState)
            try? await Task.sleep(forSeconds: 2)

            let secondState = AlertModel.timedToast(withMessage: "Time Toast", interval: 5)
            publisher.send(secondState)
            try? await Task.sleep(forSeconds: 2)

            let thirdState = AlertModel.blockingToast(withMessage: "Blocking 2")
            publisher.send(thirdState)
        }

        // Clear all alerts test
        AlertOverlay(
            manager
        ) {
            internalView
        }
        .task {
            let firstState = AlertModel.blockingToast(withMessage: "Blocking 1")
            publisher.send(firstState)
            try? await Task.sleep(forSeconds: 2)

            let actionState = AlertModel.blocking(
                withTitle: "Delayed Options Number 2",
                message: "With message...",
                actions: [
                    .init(title: "Ok", handler: { /* do nothing */ }, style: .primary),
                    .init(title: "Cancel", handler: { /* do nothing */ }, style: .secondary)
                ]
            )
            publisher.send(actionState)
            try? await Task.sleep(forSeconds: 2)

            let secondState = AlertModel.timedToast(withMessage: "Time Toast", interval: 5)
            publisher.send(secondState)
            try? await Task.sleep(forSeconds: 2)

            let thirdState = AlertModel.blockingToast(withMessage: "Blocking 2")
            publisher.send(thirdState)
            try? await Task.sleep(forSeconds: 2)

            let clearState = AlertModel.clearAllAlerts()
            publisher.send(clearState)
        }
    }


}
