//
//  SoccerAPIService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation

class SoccerAPIService : SoccerAPIRequestSending {
    private let urlEndpoint = "https://www.thesportsdb.com/api/v1/json/123/eventsday.php?"
    private let league = "German_Bundesliga"
    private let dateConverter = DateConverter()
    
    public func fetchBundesligaMatches(for date: Date) async throws -> [Event]
    {
        var urlComponents = URLComponents(string: urlEndpoint)!
                urlComponents.queryItems = [
                    URLQueryItem(name: "d", value: dateConverter.convertDateToFormattedString(input: date)),
                    URLQueryItem(name: "l", value: league)
                ]
        
        guard let url = urlComponents.url else {
                   throw URLError(.badURL)
               }
        
        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode(EventResonse.self, from: data)
            return decoded.events
        } catch {
            // todo ensure this gets logged
            print("Decoding failed with error: \(error)")
            let jsonString = String(data: data, encoding: .utf8) ?? "Invalid UTF-8"
            print("Raw JSON:\n\(jsonString)")
            return []
        }
    }
}
