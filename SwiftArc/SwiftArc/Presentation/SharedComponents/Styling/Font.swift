//
//  Font.swift
//

import SwiftUI

extension Font {
    
    enum FontStyle: String {
        case black = "Black"
        case blackItalic = "BlackItalic"
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        case italic = "Italic"
        case light = "Light"
        case lightItalic = "LightItalic"
        case regular = "Regular"
        case thin = "Thin"
        case thinItalic = "ThinItalic"
        case semiBoldItalic = "SemiBoldItalic"
        case semiBold = "SemiBold"
        case mediumItalic = "MediumItalic"
        case medium = "Medium"
        case extraLightItalic = "ExtraLightItalic"
        case extraLight = "ExtraLight"
        case extraBoldItalic = "ExtraBoldItalic"
        case extraBold = "ExtraBold"
    }
    
    enum CustomFontFamily: String {
        case lato = "Lato"
        case barlowCondensed = "BarlowCondensed"
    }

    static func customFont(
        size: CGFloat = 15,
        fontFamily: CustomFontFamily = .lato,
        style: FontStyle = .regular
    ) -> Font {
        // Please format the font file name to match this structure, <font family>-<font style>
        return .custom(fontFamily.rawValue + "-" + style.rawValue, size: size)
    }
    
    static var appLargeTitle: Font {
        customFont(size: Constants.FontSize.title, fontFamily: .lato, style: .bold)
    }
    
    static var appTitle: Font {
        customFont(size: Constants.FontSize.heading, fontFamily: .lato, style: .bold)
    }
    
    static var appSubtitle: Font {
        customFont(size: Constants.FontSize.subtitle, fontFamily: .lato, style: .regular)
    }
    
    static var appBody: Font {
        customFont(size: Constants.FontSize.body, fontFamily: .lato, style: .regular)
    }

    static var toastText: Font {
        customFont(size: Constants.ToastView.fontSize, fontFamily: .lato, style: .bold)
    }
}
