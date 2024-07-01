//
//  CloseButton.swift
//

import SwiftUI

struct CloseButton: View {
    var pressedAction: ()->Void

    var body: some View {
        Button(action: {
                pressedAction()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
            }
        )
    }
}

struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton() {
            // Do nothing
        }
    }
}
