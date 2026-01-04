//
//  LoggingService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 04.01.26.
//

import Foundation
import OSLog

class LoggingService : Logging {
    private let logger = Logger()
    
    static let shared = LoggingService()
    private init() {}
    
    func logDebug(_ message: String) {
        logger.debug("\(message)")
    }
    
    func logInfo(_ message: String) {
        logger.info("\(message)")
    }
    
    func logWarning(_ message: String) {
        logger.warning("\(message)")
    }
    
    func logError(_ message: String) {
        logger.error("\(message)")
    }
}

/// Singletons should not be cloneable.
extension LoggingService: NSCopying {

    func copy(with zone: NSZone? = nil) -> Any {
        return self
    }
}
