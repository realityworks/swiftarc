//
//  MainMenuView.swift
//  SwiftArc
//
//  Created by Piotr Suwara on 30/6/2024.
//

import SwiftUI
import Combine

struct MainMenuView: View {
    @ObservedObject var model: MainMenuViewModel = .init()
    var body: some View {
        if model.isActive {
            Color.green
        } else {
            Color.blue
        }
    }
}

#Preview {
    var appActiveSubject: CurrentValueSubject<Bool, Never> = .init(false)
    var appActivePublisher: SafePublisher<Bool> = appActiveSubject
        .eraseToAnyPublisher()

    var model: MainMenuViewModel = .init(
        dependencies: .init(appActive: appActivePublisher)
    )

    Task {
        // Do Async stuff
        try? await Task.sleep(seconds: 1)
        appActiveSubject.value = true
        try? await Task.sleep(seconds: 2)
        appActiveSubject.value = false
        try? await Task.sleep(seconds: 1)
        appActiveSubject.value = true
    }

    return MainMenuView(
        model: model
    )
}
