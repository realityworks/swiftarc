//
//  Constants.swift
//

import Foundation

struct Constants {
    struct Padding {
        static let tiny: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    struct Spacing {
        static let tiny: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
        static let extraLarge: CGFloat = 32
    }
    
    struct FontSize {
        static let caption: CGFloat = 14
        static let body: CGFloat = 18
        static let subtitle: CGFloat = 22
        static let heading: CGFloat = 25
        static let title: CGFloat = 30
    }
    
    struct ImageSize {
        static let small: CGFloat = 24
        static let medium: CGFloat = 52
        static let large: CGFloat = 65
    }
    
    struct HorizontalDivider {
        static let dividerHeight: CGFloat = 1.5
    }

    struct ToastView {
        static let minHeight: CGFloat = 32
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 2
        static let fontSize: CGFloat = 16
    }
    
    struct ActivityIndicator {
        static let spinningGlobeSize: CGFloat = 250
        static let indicatorSize: CGFloat = 280
        static let gradientStartRadius: CGFloat = 20
        static let gradientEndRadius: CGFloat = 130
        static let gradientBlur: CGFloat = 20
    }
    
    struct FadeGradient {
        static let defaultHeight: CGFloat = 24
    }
        
    struct UserInterfaceDefaults {
        static let blurRadius: CGFloat = 24
        static let pressedOpacity: CGFloat = 0.4
        static let disabledOpacity: CGFloat = 0.4
        static let transparent: CGFloat = 0.0
        static let opaque: CGFloat = 1.0
        static let dropShadowRadius: CGFloat = 5
        static let dropShadowYAxisOffset: CGFloat = 4
    }    
}
