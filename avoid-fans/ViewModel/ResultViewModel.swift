//
//  ResultViewModel.swift
//  avoid-fans
//
//  Created by Ines Bohr on 19.10.25.
//

import Foundation

final class ResultViewModel {
    @Injected(\.soccerAPIService) var soccerApiService: SoccerAPIRequestSending
    @Injected(\.matchCheckerService) var matchCheckerService : MatchChecking
    
    private var matches : [Event] = []
    
    func clashesWithAMatch(journey: Journey) -> Bool {
        Task {
            return matchCheckerService.checkForMatches(matches: matches, startDate: journey.legs.first!.arrival!, endDate: journey.legs.first!.departure!)
        }
        return false
    }
    
    func fetchMatches(journey: Journey) -> Void {
        Task {
            matches = try await soccerApiService.fetchBundesligaMatches(for: journey.legs.first!.departure!)
            return matches
        }
    }
}
