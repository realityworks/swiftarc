//
//  Color.swift
//

import SwiftUI

protocol ColorHexDefinable {
    var colorHexValue: UInt32 { get }
}

extension Color {
    enum HexCode: UInt32, ColorHexDefinable {
        var colorHexValue: UInt32 {
            self.rawValue
        }
        // Main App Palette
        case white  = 0xFFFFFF
        case gray   = 0x7F7F7F
        case red    = 0xF00000
        case cyan   = 0x00F0F0
    }
    
    struct AppColors {
        static var text: Color { Color.createColor(hexCode: HexCode.white) }

        static var errorToast: Color { Color.createColor(hexCode: HexCode.red) }
        static var notificationToast: Color { Color.createColor(hexCode: HexCode.cyan) }
        static var toastBorder: Color { Color.createColor(hexCode: HexCode.gray) }
    }

    // Opacity is between 0 and 1
    static func createColor(hexCode: ColorHexDefinable, opacity: Double = 1.0) -> Color {
        Color(hexCode: hexCode.colorHexValue, opacity: opacity)
    }
}
