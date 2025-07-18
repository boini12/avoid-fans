//
//  UserInputController.swift
//  avoid-fans
//
//  Created by Ines on 25.08.23.
//

import UIKit

class UserInputController{
    
    private let dateFormatter = DateFormatter()
    
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
