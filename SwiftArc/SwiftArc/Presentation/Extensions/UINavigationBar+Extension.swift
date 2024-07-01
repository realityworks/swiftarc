//
//  UINavigationBar+Extension.swift
//

import Foundation
import SwiftUI

extension UINavigationBar {
    func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = UIColor(Color.black)
        appearance.shadowColor = .white
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
