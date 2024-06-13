//
//  Match.swift
//  avoid-fans
//
//  Created by Ines on 13.06.24.
//

import Foundation

struct Match: Codable {
    let id: Int
    let homeTeam: Team
    let awayTeam: Team
    let utcDate: Date
    let place : String
    // Add other properties you need
}
