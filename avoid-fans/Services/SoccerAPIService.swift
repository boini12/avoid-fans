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
    
    public func fetchBundesligaMatches(for date: Date) async throws -> [Event] {
        let queryItems = [
                        URLQueryItem(
                            name: "d",
                            value: dateConverter.convertDateToFormattedString(input: date)),
                          URLQueryItem(
                            name: "l",
                            value: league)
                        ]
        
        guard let url = buildRequestUrl(
                 urlAddition: eventLookUpUrl,
                 queryItems: queryItems)
        else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        logRequest(url: url, response: response)
        
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode(EventResonse.self, from: data)
            return decoded.events
        } catch {
            handleError(data: data, error: error)
            return []
        }
    }
    
    func lookUpVenue(for id: String) async throws -> Venue? {
        let queryItems = [
                    URLQueryItem(
                    name: "id",
                    value: id)
                    ]
        
        guard let url = buildRequestUrl(urlAddition: venueLookUpUrl, queryItems: queryItems) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        logRequest(url: url, response: response)

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode(VenueResponse.self, from: data)
            return decoded.venues.first!
        } catch {
            handleError(data: data, error: error)
            return nil
        }
    }
    
    func buildRequestUrl(urlAddition: String, queryItems: [URLQueryItem]) -> URL? {
        var urlComponents = URLComponents(string: urlEndpoint + urlAddition)!
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            logger.logError("Failed to create URL from components. urlAddition: \(urlAddition), queryItems: \(queryItems)")
            return nil
        }
        
        return url
    }
    
    func handleError(data: Data, error: Error) {
        logger.logError("Decoding failed with error: \(error)")
        let jsonString = String(data: data, encoding: .utf8) ?? "Invalid UTF-8"
        logger.logError("Raw JSON:\n\(jsonString)")
    }
    
    func logRequest(url: URL, response: URLResponse) {
        logger.logInfo("Fetched data from: \(url)")
        logger.logInfo("Response from server: \(response)")
    }
}
