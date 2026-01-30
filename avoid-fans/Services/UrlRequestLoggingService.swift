//
//  UrlErrorService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 30.01.26.
//

import Foundation

class UrlRequestLoggingService : UrlRequestLogging {
    private let logger: Logging = LoggingService.shared
    
    func logDecodingError(data: Data, error: any Error) {
        logger.logError("Decoding failed with error: \(error)")
        let jsonString = String(data: data, encoding: .utf8) ?? "Invalid UTF-8"
        logger.logError("Raw JSON:\n\(jsonString)")
    }
    
    func logRequest(url: URL, response: URLResponse) {
        logger.logInfo("Fetched data from: \(url)")
        logger.logInfo("Response from server: \(response)")
    }
}
