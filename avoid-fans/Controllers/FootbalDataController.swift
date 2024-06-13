//
//  FootbalDataController.swift
//  avoid-fans
//
//  Created by Ines on 13.06.24.
//

import Foundation

class FootballDataService {
    private let apiKey = "3d7d134a17da4bf8823a335f260160a8"
    private let baseURL = "https://api.football-data.org/v2"
    
    // Singleton instance
    static let shared = FootballDataService()
    
    private init() {}
    
    // Currently only checking Bundesliga 1 matches
    /*
     Todo: Check other leagues as well
     */
    
    /// Uses the API fom football-data.org to receive all matches of the first Bundesliga
    /// - Parameter completion: if successfully completed, returns all Matches if not an exception is thrown
    func getBundesligaMatches(completion: @escaping (Result<[Match], Error>) -> Void) {
        let url = URL(string: "\(baseURL)/competitions/BL1/matches")!
        var request = URLRequest(url: url)
        request.setValue(apiKey, forHTTPHeaderField: "X-Auth-Token")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "dataNilError", code: -100001, userInfo: nil)))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601  // Use iso8601 strategy for date parsing
                let matchesResponse = try decoder.decode(MatchesResponse.self, from: data)
                completion(.success(matchesResponse.matches))
            } catch let parsingError {
                completion(.failure(parsingError))
            }
        }
        
        task.resume()
    }
}
