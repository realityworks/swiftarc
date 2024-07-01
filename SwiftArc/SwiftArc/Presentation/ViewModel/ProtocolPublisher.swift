//
//  ProtocolPublisher.swift
//

import Combine
import SwiftUI

class ProtocolPublisher<T> {
    var subject: CurrentValueSubject<T, Never>
    var binding: Binding<T>

    var allCancellables: Set<AnyCancellable> = .init()

    init(
        _ initialisorValue: T
    ) {
        self.subject = .init(initialisorValue)
        self.binding = Binding(get: {
            initialisorValue
        }, set: { _ in })

        self.binding = Binding(get: {
            self.subject.value
        }, set: { _ in })

        subject.sink { value in
            self.binding.wrappedValue = value
        }
        .store(in: &allCancellables)
    }
}
