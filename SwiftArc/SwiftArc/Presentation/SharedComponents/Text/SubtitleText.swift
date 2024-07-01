//
//  SubtitleText.swift
//

import SwiftUI

struct SubtitleText: View {
    var text: String
    var color: Color
    var alignment: TextAlignment

    init(
        _ text: String,
        color: Color = .AppColors.text,
        alignment: TextAlignment = .center
    ) {
        self.text = text
        self.color = color
        self.alignment = alignment
    }

    var body: some View {
        Text(text)
            .font(.appSubtitle)
            .multilineTextAlignment(alignment)
            .foregroundColor(color)
    }
}

struct SubtitleText_Previews: PreviewProvider {
    static var previews: some View {
        SubtitleText("This is a subtitle")
    }
}
