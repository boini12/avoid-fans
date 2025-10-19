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
    private var result : Bool = false
    
    func clashesWithAMatch(journey: Journey) -> Void {
        Task {
            result = matchCheckerService.checkForMatches(matches: matches, startDate: journey.legs.first!.arrival!, endDate: journey.legs.first!.departure!)
        }
        result = false
    }
    
    func getResult() -> String {
        if result {
            return "Your train clashes with a Bundesliga match"
        }
        return "Your train does not clash with a Bundesliga match"
    }
    
    func fetchMatches(journey: Journey) -> Void {
        Task {
            matches = try await soccerApiService.fetchBundesligaMatches(for: journey.legs.first!.departure!)
            return matches
        }
    }
}
