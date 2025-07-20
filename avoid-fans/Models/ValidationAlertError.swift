//
//  ValidationAlertError.swift
//  avoid-fans
//
//  Created by Ines Bohr on 20.07.25.
//

import Foundation

struct ValidationAlertError : LocalizedError
{
    let validationError : LocalizedError
    var errorDescription: String? {
        validationError.errorDescription
    }
    
    var recoverySuggestion: String? {
        validationError.recoverySuggestion
    }
    
    init?(error: Error?) {
        // guard is essentially an assert that also defines a fallback
        guard let localizedError = error as? LocalizedError else { return nil }
        validationError = localizedError
    }
}
