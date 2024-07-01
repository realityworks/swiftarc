//
//  AlertOverlayManager.swift
//

import Foundation
import Combine
import swiftarcstdlib

class AlertOverlayManager: ObservableObject {

    @Published var currentAlertModel: AlertModel? = nil
    @Published var showingAlert: Bool = false
    @Published var showingToast: Bool = false
    @Published private var alertStack = [AlertModel]()

    private var currentTimeToastTask: Task<(), Never>? = nil
    private var cancellables = Set<AnyCancellable>()


    init(alertState: SafePublisher<AlertModel>) {
        alertState
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] model in
                guard let self else { return }
                Logger.verbose(topic: .appState, message: "Alert displayed with model \(model)")
                if case .clearAll = model.style {
                    self.alertStack.removeAll()
                    self.showingAlert = false
                    self.showingToast = false
                } else {
                    self.alertStack.append(model)
                    self.presentAlert(with: model)
                }

            })
            .store(in: &cancellables)
    }

    @MainActor
    func dismiss() {
        showingAlert = false
        showingToast = false
        currentAlertModel = nil
        currentTimeToastTask = nil

        guard alertStack.popLast() != nil,
            let nextAlertModel = alertStack.last else {
            return
        }

        Task {
            // Note, we have to sleep here otherwise the alert won't appear if two are present simultaneously.
            try? await Task.sleep(seconds: 0.1)
            presentAlert(with: nextAlertModel)
        }
    }

    func presentAlert(with model: AlertModel) {
        if let currentTimeToastTask {
            currentTimeToastTask.cancel()
        }
        
        currentAlertModel = model

        switch model.style {
        case .blockingModal:
            showingToast = false
            showingAlert = true
        case let .timedToast(timeInterval):
            currentTimeToastTask = Task {
                try? await Task.sleep(seconds: timeInterval)

                if !Task.isCancelled {
                    await dismiss()
                }
            }
            fallthrough
        case .blockingToast:
            showingAlert = false
            showingToast = true
        default:
            Logger.info(topic: .appState, message: "AlertOverlayManager - Unhandled model")
            break //
        }
    }
}
