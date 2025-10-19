//
//  Journey.swift
//  avoid-fans
//
//  Created by Ines Bohr on 11.10.25.
//

import Foundation

struct Journey : Codable, Identifiable, Hashable {
    let id : UUID = UUID()
    let legs: [Leg]
}
