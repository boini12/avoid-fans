//
//  Logging.swift
//  avoid-fans
//
//  Created by Ines Bohr on 04.01.26.
//

import Foundation

protocol Logging {
    func logDebug(_ message: String)
    func logInfo(_ message: String)
    func logWarning(_ message: String)
    func logError(_ message: String)
}
