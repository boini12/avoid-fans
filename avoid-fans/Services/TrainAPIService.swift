//
//  TrainAPIService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 23.08.25.
//

import Foundation

class TrainAPIService : TrainAPIRequestSending {
    private let converter = DateConverter()
    private let urlEndpoint: String = "https://v6.db.transport.rest/"
    private let locationsUrl: String = "locations"
    private let journeysUrl: String = "journeys"
    private let logger: Logging = LoggingService.shared
    
    @Injected(\.urlBuilderService) var urlBuilder: UrlBuilding
    @Injected(\.responseDecodeService) var jsonDecoder: ResponseDecoding
    @Injected(\.urlRequestLoggingService) var urlRequestLoggingService: UrlRequestLogging
    
    func getId(station: String) async throws -> String {
        let queryItems = [
                        URLQueryItem(
                            name: "query",
                            value: station),
                          URLQueryItem(
                            name: "results",
                            value: "1")]
        
        guard let url = urlBuilder.buildRequestUrl(endpoint: urlEndpoint, urlAddition: locationsUrl, queryItems: queryItems) else {
            return ""
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        urlRequestLoggingService.logRequest(url: url, response: response)
        
        do {
            let result : [Station] = try jsonDecoder.decodeJSONResponse(data)
            return result.first?.id ?? ""
        } catch {
            urlRequestLoggingService.logDecodingError(data: data, error: error)
            return ""
        }
    }
    
    func getJourneys(from: String, to: String, journeyTimeSelection: JourneyTimeSelection, travelDate: Date) async throws -> [Journey] {
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
            "results": "5",
            "stopovers": "true"
        ]
        
        let queryItems = params.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        
        guard let url = urlBuilder.buildRequestUrl(endpoint: urlEndpoint, urlAddition: journeysUrl, queryItems: queryItems) else {
            return []
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        urlRequestLoggingService.logRequest(url: url, response: response)
        
        do {
            let result : JourneyResponse = try jsonDecoder.decodeJSONResponse(data)
            return result.journeys
        } catch {
            urlRequestLoggingService.logDecodingError(data: data, error: error)
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
