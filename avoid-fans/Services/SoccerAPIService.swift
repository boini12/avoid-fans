//
//  SoccerAPIService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation

class SoccerAPIService : SoccerAPIRequestSending {
    private let urlEndpoint = "https://www.thesportsdb.com/api/v1/json/123/searchevents.php?"
    private let league = "Bundesliga"
    
    public func fetchBundesligaMatches(for date: Date) async throws -> [Event]
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: date)
        
        var urlComponents = URLComponents(string: urlEndpoint)!
                urlComponents.queryItems = [
                    URLQueryItem(name: "e", value: league),
                    URLQueryItem(name: "d", value: dateString)
                ]
        
        guard let url = urlComponents.url else {
                   throw URLError(.badURL)
               }
        
        let (data, _) = try await URLSession.shared.data(from: url)

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decoded = try decoder.decode(EventResonse.self, from: data)
            return decoded.event
        } catch {
            // todo ensure this gets logged
            print("Decoding failed with error: \(error)")
            let jsonString = String(data: data, encoding: .utf8) ?? "Invalid UTF-8"
            print("Raw JSON:\n\(jsonString)")
            throw error
        }
    }
}
