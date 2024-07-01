//
//  MainMenuNavigationControl.swift
//

import SwiftUI
//import SwiftArcStdLib

//eg:
//class MainMenuNavigationControl: ObservableObject, NavigationControl {
//    typealias PathType = MainView
//    @Published var navigationPath: [PathType] = []
//    var navigationFlow: (any NavigationFlow<PathType>)? = nil
//
//    func popToRoot() {
//        Logger.info(topic: .appState, message: "Navigation - Pop to root!")
//        navigationPath.removeAll()
//    }
//
//    func pop(from view: PathType) {
//        Logger.info(topic: .appState, message: "Navigation - Move from <- \(view)")
//        navigationPath.removeAll { $0 == view }
//    }
//
//    func push(view: PathType) {
//        Logger.info(topic: .appState, message: "Navigation - Move to -> \(view)")
//
//        guard navigationPath.last != view else {
//            Logger.error(topic: .appState, message: "Navigation - Attempting to push : \(view) twice!")
//            return
//        }
//
//        navigationPath.append(view)
//    }
//}
//
//extension MainMenuNavigationControl {
//    @ViewBuilder
//    static func viewFor(mainView: MainView) -> some View {
//        let _ = Logger.info(topic: .appState, message: "View for : \(mainView)")
//        switch mainView {
//        default:
//            let _ = Logger.error(topic: .appState, message: "Device container Navigation Control does not allow \(mainView)")
//            EmptyView()
//        }
//    }
//}
