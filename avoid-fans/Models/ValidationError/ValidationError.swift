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
            return "Start date must be before end date."
        case .invalidStation:
            return "Origin and destination must be different."
        }
    }
    
    var recoverySuggestion: String? {
        switch errorType {
        case .invalidDate:
            return "Please select different dates."
        case .invalidStation:
            return "Please select different origin and destination."
        }
    }
}
