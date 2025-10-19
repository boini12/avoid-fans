//
//  MatchCheckerService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation

class MatchCheckerService : MatchChecking {
    private let converter = DateConverter()
    
    public func checkForMatches(matches : [Match], startDate: Date, endDate: Date) -> Bool {
        for match in matches {
            if let matchDate = converter.convertStringToDate(input: match.matchDateTime) as Date? {
                if matchDate >= startDate && matchDate <= endDate {
                    return true
                }
            }
        }
        return false
    }
}
