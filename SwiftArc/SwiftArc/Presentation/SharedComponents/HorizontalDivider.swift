//
//  HorizontalDivider.swift
//

import SwiftUI

struct HorizontalDivider: View {
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .frame(height: Constants.HorizontalDivider.dividerHeight)
            .edgesIgnoringSafeArea(.horizontal)
    }
}

struct HorizontalDivider_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalDivider()
    }
}
