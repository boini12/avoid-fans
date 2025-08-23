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
    @Injected(\.trainAPIService) var trainAPIService: TrainAPIRequestSending
    
    @Published var userInput: UserInput
    @Published var title: String
    @Published var error: Swift.Error?
    
    private var originId: String
    private var destinationId: String
    
    init() {
        self.userInput = UserInput()
        title = ""
        error = nil
        
        originId = ""
        destinationId = ""
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
        return [
                String(localized: "Hamburg"),
                String(localized: "Hannover"),
                String(localized: "Munich"),
                String(localized: "Cologne"),
                String(localized: "Essen"),
                String(localized: "Duisburg"),
                String(localized: "Dresden"),
                String(localized: "Berlin"),
                String(localized: "Stuttgart"),
                String(localized: "Frankfurt")
            ]
    }
    
    public func checkForFans() async throws-> Bool {
        do{
            // get ids of selected origin and destination station
            try await getStationIds()
            
            // check if there is any journey for the selected stations and time frame
            let journeyFound = try await trainAPIService.getJourney(from: originId, to: destinationId, departure: userInput.startDate, arrival: userInput.endDate)
            
            // todo: handle this in a better way
            guard journeyFound else {
                return false
            }
            
            let matches =  try await soccerApiService.fetchBundesligaMatches()
            
            // todo: check the place as well and not just date
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
    
    private func getStationIds() async throws -> Void {
        self.originId = try await trainAPIService.getId(station: getStations()[userInput.originIndex])
        self.destinationId = try await trainAPIService.getId(station: getStations()[userInput.destinationIndex])
    }
    
}
