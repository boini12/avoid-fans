//
//  StringToDateConverter.swift
//  avoid-fans
//
//  Created by Ines Bohr on 19.07.25.
//

import Foundation

struct DateConverter{
    private let dateFormatter = ISO8601DateFormatter()
    
    public func convertStringToDate(input: String) -> Date? {
        return dateFormatter.date(from: input)
    }
    
    public func convertDateToLocaleString(input: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: input)
    }
}
