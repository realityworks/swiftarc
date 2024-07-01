//
//  PublisherHelpers.swift
//

import Combine

typealias SafePublisher<T> = AnyPublisher<T, Never>

// Value type support for publishers

protocol SafePublishing {
    associatedtype SafePublisherType
}

extension SafePublishing {
    typealias SafePublisherType = SafePublisher<Self>
    typealias OptionalSafePublisherType = SafePublisher<Self?>
}

extension Just {
    func safePublisher() -> SafePublisher<Output> {
        return self
            .setFailureType(to: Never.self)
            .eraseToAnyPublisher()
    }
}
