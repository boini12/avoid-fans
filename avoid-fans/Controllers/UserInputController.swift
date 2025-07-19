//
//  UserInputController.swift
//  avoid-fans
//
//  Created by Ines on 25.08.23.
//

import Foundation

struct UserInputController{
    
    public func getStations() -> [String]
    {
        return ["Hamburg", "Hannover", "Munich", "Cologne", "Essen", "Duisburg", "Dresden", "Berlin", "Stuttgart"]
    }
    
    public func ValidDates(startDate: Date, endDate: Date) -> Bool
    {
        return startDate < endDate;
    }
    
    public func ValidStations(start: String, destination: String) -> Bool
    {
        if start.compare(destination, options: .caseInsensitive) == .orderedSame {
            return false;
        }
        return true;
    }
}
