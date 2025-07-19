//
//  APIDataController.swift
//  avoid-fans
//
//  Created by Ines Bohr on 19.07.25.
//

import Foundation

struct APIDataController {
    private var matches: [Match] = []
    private var converter = StringToDateConverter()
    
    init(matches: [Match]) {
        self.matches = matches
    }
    
    public func checkForMatches(startDate: Date, endDate: Date) -> Bool {
        for match in matches {
            // unwrap optional parameter to ensure it is not nil
            if let matchDate = converter.convert(input: match.matchDateTime) as Date? {
                if matchDate >= startDate && matchDate <= endDate {
                    return true
                }
            }
        }
        return false
    }
        
}
