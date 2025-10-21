//
//  Stopover.swift
//  avoid-fans
//
//  Created by Ines Bohr on 20.10.25.
//

import Foundation

struct Stopover: Codable, Hashable {
    let stop: Stop
    let arrival: Date?
    let departure: Date?
}
