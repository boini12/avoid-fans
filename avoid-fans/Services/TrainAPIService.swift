//
//  TrainAPIService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 23.08.25.
//

import Foundation

class TrainAPIService : TrainAPIRequestSending {
    private let converter = DateConverter()
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
    
    func getJourneys(from: String, to: String, journeyTimeSelection: JourneyTimeSelection, travelDate: Date) async throws -> [Journey] {
        var urlComponents = URLComponents(string: "\(urlEndpoint)/journeys")!
        let journeyTimeSelectionKey = createJourneyTimeSelectionKey(journeyTimeSelection: journeyTimeSelection)
        
        let params = [
            "from": from,
            "to": to,
            journeyTimeSelectionKey: ISO8601DateFormatter().string(from: travelDate),
            "nationExpress": "true",
            "national": "true",
            "regionalExpress" : "true",
            "regional": "true",
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
            "results": "5"
        ]
        
        urlComponents.queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode(JourneyResponse.self, from: data)
            return decoded.journeys
        } catch {
            // todo ensure this gets logged
            print("Decoding failed with error: \(error)")
            let jsonString = String(data: data, encoding: .utf8) ?? "Invalid UTF-8"
            print("Raw JSON:\n\(jsonString)")
            throw error
        }
    
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
