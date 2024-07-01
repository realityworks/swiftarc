//
//  UserNotificationsService.swift
//

import Foundation

enum UserNotification: String {
    case sampleNotification
}

protocol UserNotificationService {
    func notifyUser(
        with notification: UserNotification,
        title: String,
        text: String,
        userResponse: (()->())?
    )
}

