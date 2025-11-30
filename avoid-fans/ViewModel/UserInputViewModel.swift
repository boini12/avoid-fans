//
//  ValidationViewModel.swift
//  avoid-fans
//
//  Created by Ines Bohr on 20.07.25.
//

import SwiftUI

final class UserInputViewModel : ObservableObject{
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
        if(!validateStation())
        {
            error = ValidationError(errorType: ValidationErrorType.invalidStation)
            return false
        }
        return true
    }
    
    public func switchOriginAndDestination() -> Void
    {
        let tempOriginId = self.userInput.originIndex
        self.userInput.originIndex = userInput.destinationIndex
        self.userInput.destinationIndex = tempOriginId
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
    
    public func findJourneys() async throws -> [Journey] {
        do{
            // get the ids of the selected origin and destination station
            try await getStationIds()
            
            // check if there is any journey for the selected stations and time frame
            let foundJourneys = try await trainAPIService.getJourneys(
                from: originId,
                to: destinationId,
                journeyTimeSelection: userInput.journeyTimeSelection,
                travelDate: userInput.travelDate)
            
            return foundJourneys;
            
        }catch{
            return []
        }
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
