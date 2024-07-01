//
//  ToastView.swift
//

import SwiftUI

struct ToastView: View {
    var alert: AlertModel
    var dismissAction: (() -> Void)
    private var toastColor: Color {
        switch alert.indication {
        case .error:
            return Color.AppColors.errorToast
        case .notification:
            return Color.AppColors.notificationToast
        }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            if case .blockingToast = alert.style  {
                CloseButton(pressedAction: dismissAction)
                    .padding(
                        EdgeInsets(
                            top: Constants.Padding.small,
                            leading: .zero,
                            bottom: .zero,
                            trailing: Constants.Padding.small
                        )
                    )
            }
            Text(alert.message)
                .font(.toastText)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .foregroundColor(.AppColors.text)
                .padding(.top, Constants.Padding.medium)
            Spacer()
        }
        .padding([.leading, .bottom], Constants.Padding.medium)
        .frame(maxWidth: .infinity, minHeight: Constants.ToastView.minHeight)
        .background(
            toastBackground
        )
    }
    
    var toastBackground: some View {
        RoundedRectangle(
            cornerRadius: Constants.ToastView.cornerRadius,
            style: .continuous
        )
        .fill(toastColor)
        .background(
            RoundedRectangle(
                cornerRadius: Constants.ToastView.cornerRadius,
                style: .continuous
            )
            .stroke(
                Color.AppColors.toastBorder,
                lineWidth: Constants.ToastView.borderWidth
            )
        )
    }
}

struct ToastView_Previews: PreviewProvider {
    static var alert: AlertModel = AlertModel.blockingToast(withMessage: "This text cannot fit in one line so it has to warp around to the next line.")
    
    static var previews: some View {
        ToastView(alert: alert) {}
    }
}
