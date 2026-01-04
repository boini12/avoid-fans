//
//  MatchCheckerService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation

class MatchCheckerService : MatchChecking {
    private let soccerApiService = SoccerAPIService()
    private let converter = DateConverter()
    private let variance = 2
    private let logger: Logging = LoggingService.shared
    
    public func checkForMatches(matches: [Event], venues: [Venue], leg: Leg) -> Bool {
        if matches.isEmpty ||
            venues.isEmpty {
            return false
        }
        
        if let departure = leg.departure,
           let arrival = leg.arrival,
           let stopovers = leg.stopovers,
           let destination = leg.destination
        {
            let matchesDuringTravelTime = checkDateAndTime(matches: matches, startDate: departure, endDate: arrival)
            
            var locationMatched = false
            
            if(stopovers.isEmpty){
                locationMatched = checkOriginAndDestination(
                    matches: matchesDuringTravelTime,
                    venues: venues,
                    destination: destination.name)
            }else {
                locationMatched = checkStops(matches: matchesDuringTravelTime, venues: venues, stopovers: stopovers)
            }
            
            return locationMatched
        }
            
        return false
    }
    
    private func checkOriginAndDestination(matches: [Event], venues: [Venue], destination: String) -> Bool {
        let cleanedDestination = destination.components(separatedBy: .whitespaces)[0].lowercased()
        
        for venue in venues {
            let venueCity = venue.strLocation.components(separatedBy: ",")[0].lowercased()
            if venueCity.contains(cleanedDestination) || cleanedDestination.contains(venueCity) {
                return true
            }
                
        }
        return false
    }
    
    private func checkStops(matches: [Event], venues: [Venue], stopovers: [Stopover]) -> Bool {
        let combined = matches.compactMap { match -> (Event, Venue)? in
            guard let venue = venues.first(where: { $0.idVenue == match.idVenue }) else { return nil }
            return (match, venue)
        }
        
        for (_, venue) in combined {
            if stopovers.contains(where: { stopover in
                let stopName = stopover.stop.name.lowercased()
                return stopName.contains(venue.strLocation) || venue.strLocation.contains(stopName)
            }){
                return true
            }
        }
        return false
    }
    
    private func checkDateAndTime(matches: [Event], startDate: Date, endDate: Date) -> [Event] {
        let adjustedStart = startDate.addingTimeInterval(TimeInterval(-variance * 60 * 60))
        let adjustedEnd = endDate.addingTimeInterval(TimeInterval(variance * 60 * 60))
        
        var result: [Event] = []
        
        for match in matches {
            
            let matchDate = converter.convertFormattedStringToDate(date: match.dateEvent, time: match.strTime)
            let matchEnd = matchDate?.addingTimeInterval(TimeInterval(120 * 60))
            
            if let matchDate = converter.convertFormattedStringToDate(date: match.dateEvent, time: match.strTime) as Date? {
                if (matchDate >= adjustedStart && matchDate <= adjustedEnd) || (matchEnd! >= adjustedEnd && matchEnd! <= adjustedStart) {
                    result.append(match)
                }
            }
        }
        return result
    }
}
