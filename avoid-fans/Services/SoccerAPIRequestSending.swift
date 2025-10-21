//
//  SoccerAPIRequestSending.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation

protocol SoccerAPIRequestSending {
    func fetchBundesligaMatches(for date: Date) async throws -> [Event]
    func lookUpVenue(for id: String) async throws -> Venue?
}

extension InjectedValues {
    var soccerAPIService : SoccerAPIRequestSending {
        get { Self[SoccerAPIServiceKey.self]}
        set { Self [SoccerAPIServiceKey.self] = newValue}
    }
}

private struct SoccerAPIServiceKey: InjectionKey {
    static var currentValue: SoccerAPIRequestSending = SoccerAPIService()
}
