//
//  ResultViewModel.swift
//  avoid-fans
//
//  Created by Ines Bohr on 19.10.25.
//

import Foundation

final class ResultViewModel : ObservableObject {
    @Injected(\.soccerAPIService) var soccerApiService: SoccerAPIRequestSending
    @Injected(\.matchCheckerService) var matchCheckerService : MatchChecking
    
    private var matches : [Event] = []
    private var venues : [Venue] = []
    @Published var resultText : String = ""
    
    func checkForClash(journey: Journey) async -> Void {
        do {
            matches = try await soccerApiService.fetchBundesligaMatches(for: journey.legs.first!.departure!)
            for match in matches {
                venues.append(try await soccerApiService.lookUpVenue(for: match.idVenue)!)
            }
           
           let result = isClash(journey: journey)
           
           await MainActor.run {
               self.resultText = result ? "Clash!" : "No Clash!"
           }
        }catch {
            print("Error fetching matches")
        }
   }
    
    private func isClash(journey: Journey) -> Bool {
        return matchCheckerService.checkForMatches(matches: matches, venues: venues, leg: journey.legs.last!)
    }
}
