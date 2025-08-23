//
//  SoccerAPIService.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation

class SoccerAPIService : SoccerAPIRequestSending {
    private let urlEndpoint = "https://api.openligadb.de/getmatchdata/bl1"
    
    public func fetchBundesligaMatches() async throws -> [Match]
    {
        // the underscore reflects the url response here
        // right now I'm just discarding it
        // todo: This should be adjusted in the future to check the respone
        let (data, response) = try await URLSession.shared.data(from: URL(string: urlEndpoint)!)
        let matches = try JSONDecoder().decode([Match].self, from: data)
        return matches
    }
}
