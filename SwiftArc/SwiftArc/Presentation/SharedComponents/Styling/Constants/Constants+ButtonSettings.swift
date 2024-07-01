//
//  Constants+ButtonSettings.swift
//

import Foundation

extension Constants {
    struct ButtonSettings {
        var width: CGFloat
        var height: CGFloat
        var cornerRadius: CGFloat
        var fontSize: CGFloat
    }
}

extension Constants.ButtonSettings {
    struct Primary {
        static var small: Constants.ButtonSettings {
            .init(
                width: 100,
                height: 35,
                cornerRadius: 9,
                fontSize: 14
            )
        }
        
        static var medium: Constants.ButtonSettings {
            Constants.ButtonSettings(
                width: 150,
                height: 50,
                cornerRadius: 3,
                fontSize: 20
            )
        }
        
        static var large: Constants.ButtonSettings {
            Constants.ButtonSettings(
                width: 240,
                height: 40,
                cornerRadius: 5,
                fontSize: 20
            )
        }
        
        static var extraLarge: Constants.ButtonSettings {
            Constants.ButtonSettings(
                width: 230,
                height: 70,
                cornerRadius: 8,
                fontSize: 25
            )
        }
    }
        
    struct Secondary {
        static var small: Constants.ButtonSettings {
            Constants.ButtonSettings(
                width: 100,
                height: 35,
                cornerRadius: 14,
                fontSize: 14
            )
        }
        
        static var medium: Constants.ButtonSettings {
            Constants.ButtonSettings(
                width: 150,
                height: 40,
                cornerRadius: 3,
                fontSize: 20
            )
        }
        
        static var large: Constants.ButtonSettings {
            Constants.ButtonSettings(
                width: 240,
                height: 40,
                cornerRadius: 5,
                fontSize: 17
            )
        }
        
        static var extraLarge: Constants.ButtonSettings {
            Constants.ButtonSettings(
                width: 230,
                height: 70,
                cornerRadius: 5,
                fontSize: 20
            )
        }
    }
}

