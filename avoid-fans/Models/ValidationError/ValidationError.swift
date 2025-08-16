//
//  ValidationError.swift
//  avoid-fans
//
//  Created by Ines Bohr on 20.07.25.
//

import SwiftUI

struct ValidationError : LocalizedError
{
    let errorType: ValidationErrorType
    
    var errorDescription: String? {
        switch errorType {
        case .invalidDate:
            return String(localized: "Start date must be before end date.")
        case .invalidStation:
            return String(localized: "Origin and destination must be different.")
        }
    }
    
    var recoverySuggestion: String? {
        switch errorType {
        case .invalidDate:
            return String(localized: "Please select different dates.")
        case .invalidStation:
            return String(localized:"Please select different origin and destination.")
        }
    }
}
