//
//  URLConstants.swift
//

import Foundation

struct URLConstants {
    private enum URLPathComponent: String {
        case website = "website"
        case privacyPolicy = "privacyPolicy"
        case termsAndConditions = "terms"
    }

    private static func siteUrl(withPathComponent component: URLPathComponent) -> URL? {
        var baseUrl = try? Configuration.siteURL
        return baseUrl?.appending(component: component.rawValue)
    }

    static var website: URL? {
        siteUrl(withPathComponent: .website)
    }

    static var termsAndConditions: URL? {
        siteUrl(withPathComponent: .termsAndConditions)
    }

    static var privacyPolicy: URL? {
        siteUrl(withPathComponent: .privacyPolicy)
    }
}
