//
//  UIImage+Extension.swift
//

import Foundation
import SwiftUI

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil        }
        context.setFillColor(color.cgColor)
        context.fill(rect)
        guard let image = context.makeImage() else {
            return nil
        }
        UIGraphicsEndImageContext()

        self.init(cgImage: image)
    }
}
