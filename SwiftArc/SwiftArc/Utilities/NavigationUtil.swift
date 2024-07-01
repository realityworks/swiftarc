//
//  NavigationUtil.swift
//

import SwiftUI

struct NavigationUtil {
    static func popToRootView() {
        let viewController = UIApplication.shared.windows.filter {
            $0.isKeyWindow
        }.first?.rootViewController

        guard let viewController else {
            return
        }

        findNavigationController(viewController: viewController)?
            .popToRootViewController(animated: true)
    }

    fileprivate static func findNavigationController(
        viewController: UIViewController
    ) -> UINavigationController? {
        if let navigationController = viewController as? UINavigationController {
            return navigationController
        }

        for childViewController in viewController.children {
            return findNavigationController(viewController: childViewController)
        }

        return nil
    }
}
