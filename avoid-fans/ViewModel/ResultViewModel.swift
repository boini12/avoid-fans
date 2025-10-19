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
    @Published var resultText : String = ""
    
    func checkForClash(journey: Journey) async -> Void {
        do {
            matches = try await soccerApiService.fetchBundesligaMatches(for: journey.legs.first!.departure!)
           
           let result = isClash(journey: journey)
           
           await MainActor.run {
               self.resultText = result ? "Clash!" : "No Clash!"
           }
        }catch {
            print("Error fetching matches")
        }
   }
    
    private func isClash(journey: Journey) -> Bool {
        return matchCheckerService.checkForMatches(matches: matches, startDate: journey.legs.first!.departure!, endDate: journey.legs.first!.arrival!)
    }
}
