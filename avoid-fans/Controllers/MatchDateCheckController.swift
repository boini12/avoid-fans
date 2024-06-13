//
//  MatchDateCheckController.swift
//  avoid-fans
//
//  Created by Ines on 13.06.24.
//

import Foundation

class MatchDateCheckController{
    
    private let dateFormatter = DateFormatter()
    private let date1 = Date.now
    
    func checkForMatchOnDate(userInput : UserInput, matches : [Match]) -> Bool{
        let startDate = userInput.startDate
        let endDate = userInput.endDate
        
        return isMatchFound(start: startDate, end: endDate, matches: <#T##[Match]#>)
    }
    
    
    /// Find Football matches that occur during the time provided
    /// - Parameters:
    ///   - start: represents the start of a journey
    ///   - end: represents the end of a journey
    ///   - matches: football matches that shall be cross checked with the dates
    /// - Returns: true if match found, false if no match is found
    func isMatchFound(start : Date, end : Date, matches : [Match]) -> Bool{
        for match in matches {
            if (start...end).contains(match.utcDate) {
                return true
            }
        }
        return false;
    }
}

