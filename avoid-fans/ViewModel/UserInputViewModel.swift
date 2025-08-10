//
//  ValidationViewModel.swift
//  avoid-fans
//
//  Created by Ines Bohr on 20.07.25.
//

import SwiftUI

final class UserInputViewModel : ObservableObject {
    @Injected(\.soccerAPIService) var soccerApiService: SoccerAPIRequestSending
    @Injected(\.matchCheckerService) var matchCheckerService : MatchChecking
    
    @Published var userInput: UserInput
    
    @Published var title: String
    @Published var error: Swift.Error?
    
    init() {
        self.userInput = UserInput()
        title = ""
        error = nil
    }
    
    public func validate() -> Bool
    {
        if(!validateDates())
        {
            error = ValidationError(errorType: ValidationErrorType.invalidDate)
            return false
        }
        
        if(!validateStation())
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
    
    public func checkForFans() async -> Bool {
        do{
            let matches =  try await soccerApiService.fetchBundesligaMatches()
            
            let result = matchCheckerService.checkForMatches(
                matches: matches,
                startDate: userInput.startDate,
                endDate: userInput.endDate)
            return result;
        }catch{
            // do nothing for now
        }
        return true;
    }
    
    private func validateDates() -> Bool
    {
        return userInput.startDate < userInput.endDate;
    }
    
    private func validateStation() -> Bool
    {
        let origin = getStations()[userInput.originIndex]
        let destination = getStations()[userInput.destinationIndex]
        
        if origin.compare(destination, options: .caseInsensitive) == .orderedSame {
            return false;
        }
        return true;
    }
    
}
