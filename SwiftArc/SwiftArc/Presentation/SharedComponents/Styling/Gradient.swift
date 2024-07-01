//
//  Gradient.swift

//

import SwiftUI

extension Gradient {
    // The Array containing all the stops for a gradient is ordered from the first color stop to the last color stop
    struct GradientStops {
        static let fadeGradient: [CGFloat] = [0, 1]
        static let secondaryComponentBackground: [CGFloat] = [0, 0.4, 0.8, 1]
        static let activityOverlay: [CGFloat] = [0, 1]
    }
    
    struct AppGradients {
        static let fadeGradient = Gradient(
            stops: [
                Gradient.Stop(
                    color: .gray,
                    location: GradientStops.fadeGradient[0]
                ),
                Gradient.Stop(
                    color: .clear,
                    location: GradientStops.fadeGradient[1]
                )
            ]
        )
        
        static let activityOverlay = Gradient(
            stops: [
                Gradient.Stop(
                    color: .black,
                    location: GradientStops.activityOverlay[0]
                ),
                Gradient.Stop(
                    color: .clear,
                    location: GradientStops.activityOverlay[1]
                )
            ]
        )
    }
}
