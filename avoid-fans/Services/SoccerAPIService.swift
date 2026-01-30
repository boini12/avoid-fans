//
//  SoccerAPIService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation

class SoccerAPIService : SoccerAPIRequestSending {
    private let urlEndpoint = "https://www.thesportsdb.com/api/v1/json/123/"
    private let eventLookUpUrl = "eventsday.php?"
    private let venueLookUpUrl = "lookupvenue.php?"
    private let league = "German_Bundesliga"
    private let dateConverter = DateConverter()
    private let logger : Logging = LoggingService.shared
    
    @Injected(\.urlBuilderService) var urlBuilder: UrlBuilding
    @Injected(\.responseDecodeService) var jsonDecoder: ResponseDecoding
    @Injected(\.urlRequestLoggingService) var urlRequestLoggingService: UrlRequestLogging
    
    public func fetchBundesligaMatches(for date: Date) async throws -> [Event] {
        let queryItems = [
                        URLQueryItem(
                            name: "d",
                            value: dateConverter.convertDateToFormattedString(input: date)),
                          URLQueryItem(
                            name: "l",
                            value: league)
                        ]
        
        guard let url = urlBuilder.buildRequestUrl(endpoint: urlEndpoint, urlAddition: eventLookUpUrl, queryItems: queryItems)
        else {
            return []
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        urlRequestLoggingService.logRequest(url: url, response: response)
        
        do {
            let result : EventResonse = try jsonDecoder.decodeJSONResponse(data)
            return result.events
        } catch {
            urlRequestLoggingService.logDecodingError(data: data, error: error)
            return []
        }
    }
    
    func lookUpVenue(for id: String) async throws -> Venue? {
        let queryItems = [
                    URLQueryItem(
                    name: "id",
                    value: id)
                    ]
        
        guard let url = urlBuilder.buildRequestUrl(endpoint: urlEndpoint, urlAddition: venueLookUpUrl, queryItems: queryItems) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        urlRequestLoggingService.logRequest(url: url, response: response)

        do {
            let result : VenueResponse = try jsonDecoder.decodeJSONResponse(data)
            return result.venues.first
        } catch {
            urlRequestLoggingService.logDecodingError(data: data, error: error)
            return nil
        }
    }
}
