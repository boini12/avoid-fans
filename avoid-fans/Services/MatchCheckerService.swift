//
//  MatchCheckerService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation

class MatchCheckerService {
    private var matches: [Match] = []
    private var converter = StringToDateConverter()
    
    init(matches: [Match]) {
        self.matches = matches
    }
    
    public func checkForMatches(startDate: Date, endDate: Date) -> Bool {
        for match in matches {
            if let matchDate = converter.convert(input: match.matchDateTime) as Date? {
                if matchDate >= startDate && matchDate <= endDate {
                    return true
                }
            }
        }
        return false
    }
}
