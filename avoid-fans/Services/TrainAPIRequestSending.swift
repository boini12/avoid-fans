//
//  TrainAPIServiceSending.swift
//  avoid-fans
//
//  Created by Ines Bohr on 23.08.25.
//

import Foundation

protocol TrainAPIRequestSending {
    func getId(station: String) async throws -> String
    func getJourney(from: String, to: String, departure: Date, arrival: Date) async throws -> Bool
}

extension InjectedValues {
    var trainAPIService : TrainAPIRequestSending {
        get {
            Self[TrainAPIServiceKey.self]
        }
        set {
            Self[TrainAPIServiceKey.self] = newValue
        }
    }
}

private struct TrainAPIServiceKey: InjectionKey {
    static var currentValue: TrainAPIRequestSending = TrainAPIService()
}
