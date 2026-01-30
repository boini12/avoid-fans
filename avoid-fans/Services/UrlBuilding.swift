//
//  UrlBuilding.swift
//  avoid-fans
//
//  Created by Ines Bohr on 30.01.26.
//

import Foundation

protocol UrlBuilding {
    func buildRequestUrl(endpoint: String, urlAddition: String, queryItems: [URLQueryItem]) -> URL?
}

extension InjectedValues {
    var urlBuilderService : UrlBuilding {
        get { Self[UrlBuilderServiceKey.self]}
        set { Self [UrlBuilderServiceKey.self] = newValue}
    }
}

private struct UrlBuilderServiceKey: InjectionKey {
    static var currentValue: UrlBuilding = UrlBuilderService()
}
