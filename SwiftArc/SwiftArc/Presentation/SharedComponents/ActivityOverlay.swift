//
//  LoadingIndicator.swift
//

import SwiftUI

struct ActivityOverlay<Content: View>: View {
    @Binding var active: Bool
    var text: String

    var content: Content

    init(
        active: Binding<Bool>,
        text: String = "",
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._active = active
        self.text = text
        self.content = content()
    }
    
    var activityIndicator: some View {
        TitleText("LOADING")
            .background(Color.black)
//        ZStack(alignment: .top) {
//            if !text.isEmpty {
//                TitleText(text)
//                    .lineLimit(1)
//            }
//            LottieView(.spinningGlobe, contentMode: .scaleAspectFill)
//                .frame(height: Constants.ActivityIndicator.spinningGlobeSize)
//        }
//        .frame(
//            width: Constants.ActivityIndicator.indicatorSize,
//            height: Constants.ActivityIndicator.indicatorSize)
//        .background(
//            RadialGradient(
//                gradient: .IqGradients.activityOverlay,
//                center: .center,
//                startRadius: Constants.ActivityIndicator.gradientStartRadius,
//                endRadius: Constants.ActivityIndicator.gradientEndRadius
//            )
//            .blur(radius: Constants.ActivityIndicator.gradientBlur)
//            .padding([.trailing, .bottom], Constants.Padding.small)
//        )
    }

    var body: some View {
        ZStack(alignment: .center) {
            content
                .blur(radius: active
                      ? Constants.UserInterfaceDefaults.blurRadius
                      : 0)
                .allowsHitTesting(!active)
                .animation(.easeInOut, value: active)
            
            if active {
                activityIndicator
            }
        }
        .background(
            Color.black
        )
    }
}

struct ActivityOverlay_Previews: PreviewProvider {
    static var previews: some View {
        ActivityOverlay(active: .constant(false)) {
            VStack {
                List {
                    Text("This is a test")
                    Text("This is a test")
                    Text("This is a test")
                }
            }
        }

        ActivityOverlay(active: .constant(true), text: "Logging you in") {
            ZStack {
                List {
                    Text("This is a test")
                    Text("This is a test")
                    Text("This is a test")
                }
                .scrollContentBackground(.hidden)
                .background(
                    Color.black
                )
            }
        }
    }
}
