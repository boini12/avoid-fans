//
//  UrlErrorHandling.swift
//  avoid-fans
//
//  Created by Ines Bohr on 30.01.26.
//

import Foundation

protocol UrlRequestLogging {
    func logDecodingError(data: Data, error: Error) -> Void
    func logRequest(url: URL, response: URLResponse) -> Void
}

extension InjectedValues {
    var urlRequestLoggingService : UrlRequestLogging {
        get { Self[UrlRequestLoggingServiceKey.self]}
        set { Self [UrlRequestLoggingServiceKey.self] = newValue}
    }
}

private struct UrlRequestLoggingServiceKey: InjectionKey {
    static var currentValue: UrlRequestLogging = UrlRequestLoggingService()
}
