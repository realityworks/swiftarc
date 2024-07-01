//
//  LiveUserNotificationService.swift
//

import Foundation
import swiftarcstdlib
import UserNotifications

class LiveUserNotificationService: UserNotificationService {
    let notificationCenter = UNUserNotificationCenter.current()
    var notificationsGranted = false

    init() {
        Logger.info(topic: .other, message: "Initialising notifications system...")

        Logger.info(topic: .other, message: "Requesting permissions")
        notificationCenter.requestAuthorization(options: [.alert, .badge]) { granted, error in
            self.notificationsGranted = granted

            if let error {
                Logger.error(topic: .other, message: "Notification permissions auth request failed with error : \(error)")
            }

            Logger.info(topic: .other, message: "Notification permissions = \(self.notificationsGranted)")
        }
    }

    func notifyUser(
        with notification: UserNotification,
        title: String,
        text: String,
        userResponse: (()->())? = nil
    ) {
        Task {
            let notificationSettings = await notificationCenter.notificationSettings()
            guard notificationSettings.authorizationStatus == .authorized else {
                Logger.warning(topic: .other, message: "Notification permissions have not been authorised, will not send : \(notification)")
                return
            }

            Logger.warning(topic: .other, message: "Requesting to send \(notification) with title : \(title) and text : \(text)")

            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = title
            notificationContent.body = text

            let request = UNNotificationRequest(
                identifier: "\(notification.rawValue)_\(UUID().uuidString)",
                content: notificationContent,
                trigger: nil
            )

            userResponse?()

            do {
                try await notificationCenter.add(request)
            } catch {
                Logger.warning(topic: .other, message: "Adding notification failed with error : \(error)")
            }
        }
    }
}
