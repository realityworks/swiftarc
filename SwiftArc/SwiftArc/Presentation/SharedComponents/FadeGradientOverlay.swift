//
//  FadeGradient.swift
//

import SwiftUI

struct FadeGradientOverlay<Content: View>: View {
    var content: Content
    var scrolling: Bool
    var topOffset: CGFloat
    var bottomOffset: CGFloat
    var gradientHeight: CGFloat
    var gradient = Gradient.AppGradients.fadeGradient

    init(
        scrolling: Bool = false,
        topOffset: CGFloat = 0.0,
        bottomOffset: CGFloat = 0.0,
        gradientHeight: CGFloat = Constants.FadeGradient.defaultHeight,
        content: @escaping () -> Content
    ) {
        self.scrolling = scrolling
        self.topOffset = topOffset
        self.bottomOffset = bottomOffset
        self.gradientHeight = gradientHeight
        self.content = content()
    }
    // Please add vertical padding to the content that is passed in to avoid issue of the first
    // item being covered by the gradient. Recommend padding amount is 40 for full clearence of
    // the gradient.
    var body: some View {
        ZStack {
            if scrolling {
                ScrollView {
                    Spacer()
                        .frame(height: topOffset)
                    content
                    Spacer()
                        .frame(height: bottomOffset)
                }
            } else {
                content
            }
            VStack {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: gradient,
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: gradientHeight)
                Spacer()
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: gradient,
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                    .frame(height: gradientHeight)
            }
            .allowsHitTesting(false)
        }
    }
}

struct FadeGradient_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Rectangle()
                .frame(height: 80)
            FadeGradientOverlay {
                ScrollView {
                    VStack {
                        ForEach(0..<50) { _ in
                            Capsule()
                                .frame(height: 40)
                        }
                    }
                    .padding(.vertical, 38)
                    
                }
            }
            Rectangle()
                .frame(height: 80)
        }
        .background(Color.green)
    }
}
