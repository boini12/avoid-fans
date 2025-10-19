//
//  MatchCheckerService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation

class MatchCheckerService : MatchChecking {
    private let converter = DateConverter()
    private let variance = 2
    
    public func checkForMatches(matches : [Event], startDate: Date, endDate: Date) -> Bool {
        let adjustedStart = startDate.addingTimeInterval(TimeInterval(-variance * 60 * 60))
        let adjustedEnd = endDate.addingTimeInterval(TimeInterval(variance * 60 * 60))
        
        for match in matches {
            
            let matchDate = converter.convertFormattedStringToDate(date: match.dateEvent, time: match.strTime)
            let matchEnd = matchDate?.addingTimeInterval(TimeInterval(120 * 60))
            
            if let matchDate = converter.convertFormattedStringToDate(date: match.dateEvent, time: match.strTime) as Date? {
                if (matchDate >= adjustedStart && matchDate <= adjustedEnd) || (matchEnd! >= adjustedEnd && matchEnd! <= adjustedStart) {
                    return true
                }
            }
        }
        return false
    }
}
