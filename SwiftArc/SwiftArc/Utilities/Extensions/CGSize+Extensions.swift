//
//  CGSize+Extensions.swift
//

import Foundation

extension CGSize {
    init(scalar: CGFloat) {
        self.init(width: scalar, height: scalar)
    }

    static func scalar(_ scalar: CGFloat) -> CGSize {
        CGSize(scalar: scalar)
    }
}
