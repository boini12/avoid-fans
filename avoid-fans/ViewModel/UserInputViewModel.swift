//
//  ValidationViewModel.swift
//  avoid-fans
//
//  Created by Ines Bohr on 20.07.25.
//

import SwiftUI

final class UserInputViewModel : ObservableObject {
    private let SoccerAPIService: SoccerAPIService
    private let MatchCheckerService : MatchCheckerService
    
    @Published var title: String = ""
    @Published var error: Swift.Error? = nil
    
    public func validate(input: UserInput) -> Bool
    {
        if(!validateDate(startDate: input.startDate, endDate: input.endDate))
        {
            error = ValidationError(errorType: ValidationErrorType.invalidDate)
            return false
        }
        
        if(!validateStation(origin: input.origin, destination: input.destination))
        {
            error = ValidationError(errorType: ValidationErrorType.invalidStation)
            return false
        }
        return true
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
