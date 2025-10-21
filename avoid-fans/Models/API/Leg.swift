//
//  Leg.swift
//  avoid-fans
//
//  Created by Ines Bohr on 11.10.25.
//

import Foundation

struct Leg : Codable, Hashable {
    let departure: Date?
    let arrival: Date?
    let destination: Stop?
    let stopovers: [Stopover]?
}
