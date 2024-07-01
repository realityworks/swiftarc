//
//  MainMenuViewModel.swift
//  SwiftArc
//
//  Created by Piotr Suwara on 30/6/2024.
//

import Foundation

class MainMenuViewModel: ViewModel {
    
    @Published var isActive: Bool = false

    init(dependencies: Dependencies = .standard) {
        dependencies.appActive
            .assign(to: &$isActive)
    }
}

extension MainMenuViewModel {

    struct Dependencies {
        var appActive: SafePublisher<Bool>

        static let standard: Dependencies = .init(
            appActive: Domain.shared.stateController.publisher(for: \.app.isActive)
        )
    }
}
