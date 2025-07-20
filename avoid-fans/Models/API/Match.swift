//
//  Match.swift
//  avoid-fans
//
//  Created by Ines Bohr on 19.07.25.
//

struct Match : Codable {
    let matchDateTime: String
    let team1: Team
    let team2: Team
    let matchResults: [MatchResult]?
}
