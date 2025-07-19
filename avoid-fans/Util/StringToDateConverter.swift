//
//  StringToDateConverter.swift
//  avoid-fans
//
//  Created by Ines Bohr on 19.07.25.
//

import Foundation

struct StringToDateConverter{
    private let dateFormatter = ISO8601DateFormatter()
    
    public func convert(input: String) -> Date? {
        return dateFormatter.date(from: input)
    }
}
