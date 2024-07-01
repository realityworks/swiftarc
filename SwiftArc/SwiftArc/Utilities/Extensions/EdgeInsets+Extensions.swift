//
//  EdgeInsets+Extensions.swift
//

import SwiftUI

extension EdgeInsets {
    init(horizontal: CGFloat, vertical: CGFloat) {
        self.init(
            top: vertical,
            leading: horizontal,
            bottom: vertical,
            trailing: horizontal
        )
    }
}
