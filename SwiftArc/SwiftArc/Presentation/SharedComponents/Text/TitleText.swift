//
//  TitleText.swift
//

import SwiftUI

struct TitleText: View {
    var text: String
    var color: Color
    var alignment: TextAlignment

    init(
        _ text: String,
        color: Color = Color.AppColors.text,
        alignment: TextAlignment = .center
    ) {
        self.text = text
        self.color = color
        self.alignment = alignment
    }

    var body: some View {
        Text(text)
            .font(.appTitle)
            .multilineTextAlignment(alignment)
            .foregroundColor(color)
    }
}

struct TitleText_Previews: PreviewProvider {
    static var previews: some View {
        TitleText("This is a TITLE")
    }
}
