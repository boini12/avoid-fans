//
//  TrainAPIService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 23.08.25.
//

import Foundation

class TrainAPIService : TrainAPIRequestSending {
    private let converter = StringToDateConverter()
    private let urlEndpoint: String = "https://v6.db.transport.rest"
    
    func getId(station: String) async throws -> String {
        var urlComponents = URLComponents(string: "\(urlEndpoint)/locations")!
        let params = ["query": station, "results": "1"]
        
        urlComponents.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        // todo: react to response and handle possible error
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let stations = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: Any]]
        
        let stationObj = stations?.first
        
        guard stationObj != nil else {
            return ""
        }
        
        let id = stationObj?["id"] as! String
        
        return id
    }
    
    func getJourney(from: String, to: String, journeyTimeSelection: JourneyTimeSelection, travelDate: Date) async throws -> Bool {
        var urlComponents = URLComponents(string: "\(urlEndpoint)/journeys")!
        let journeyTimeSelectionKey = createJourneyTimeSelectionKey(journeyTimeSelection: journeyTimeSelection)
        
        let params = [
            "from": from,
            "to": to,
            journeyTimeSelectionKey: ISO8601DateFormatter().string(from: Date()),
            "nationExpress": "true",
            "national": "false",
            "regionalExpress" : "false",
            "regional": "false",
            "suburban": "false",
            "bus": "false",
            "ferry": "false",
            "subway": "false",
            "tram": "false",
            "taxi": "false",
            "remarks": "false",
            "entrances": "false",
            "subStops": "false",
            "startWalkingWith": "false",
            "results": "1"
        ]
        
        urlComponents.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let journeys = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any]
        
        let journeyObj = journeys?.first
        
        return journeyObj != nil ? true : false
    }
    
    private func createJourneyTimeSelectionKey(journeyTimeSelection: JourneyTimeSelection) -> String {
        switch journeyTimeSelection {
            case .Departure:
                return "departure"
                
            case .Arrival:
                return "arrival"
            }
    }
}
