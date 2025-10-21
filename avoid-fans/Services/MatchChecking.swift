//
//  MatchChecking.swift
//  avoid-fans
//
//  Created by Ines Bohr on 10.08.25.
//

import Foundation

protocol MatchChecking {
    func checkForMatches(matches: [Event], venues: [Venue], leg: Leg) -> Bool
}

extension InjectedValues {
    var matchCheckerService : MatchChecking {
        get { Self[MatchCheckerServiceKey.self]}
        set { Self [MatchCheckerServiceKey.self] = newValue}
    }
}

private struct MatchCheckerServiceKey: InjectionKey {
    static var currentValue: MatchChecking = MatchCheckerService()
}
