//
//  ValidationViewModel.swift
//  avoid-fans
//
//  Created by Ines Bohr on 20.07.25.
//

import SwiftUI

final class UserInputViewModel : ObservableObject {
    @Published var title: String = ""
    @Published var error: Swift.Error? = nil
    
    enum ValidationError : LocalizedError
    {
        case invalidDate
        case invalidStation
        
        var errorDescription: String? {
            switch self {
            case .invalidDate:
                return "Start date must be before end date."
            case .invalidStation:
                return "Origin and destination must be different."
            }
        }
        
        var recoverySuggestion: String? {
            switch self {
            case .invalidDate:
                return "Please select different dates."
            case .invalidStation:
                return "Please select different origin and destination."
            }
        }
    }
    
    public func validate(input: UserInput)
    {
        if(!validateDate(startDate: input.startDate, endDate: input.endDate))
        {
            error = ValidationError.invalidDate
            return
        }
        
        if(!validateStation(origin: input.origin, destination: input.destination))
        {
            error = ValidationError.invalidStation
            return
        }
    }
    
    public func getStations() -> [String]
    {
        return ["Hamburg", "Hannover", "Munich", "Cologne", "Essen", "Duisburg", "Dresden", "Berlin", "Stuttgart"]
    }
    
    private func validateDate(startDate: Date, endDate: Date) -> Bool
    {
        return startDate < endDate;
    }
    
    private func validateStation(origin: String, destination: String) -> Bool
    {
        if origin.compare(destination, options: .caseInsensitive) == .orderedSame {
            return false;
        }
        return true;
    }
    
}
