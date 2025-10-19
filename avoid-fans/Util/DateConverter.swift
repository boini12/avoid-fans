//
//  StringToDateConverter.swift
//  avoid-fans
//
//  Created by Ines Bohr on 19.07.25.
//

import Foundation

struct DateConverter{
    private let dateFormatter = ISO8601DateFormatter()
    
    public func convertFormattedStringToDate(date: String, time: String) -> Date? {
        let dateFormatter = DateFormatter()
        let dateTimeString = "\(date.trimmingCharacters(in: .whitespaces)) \(time.trimmingCharacters(in: .whitespaces))"
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.date(from: dateTimeString)
    }
    
    public func convertDateToFormattedString(input: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: input)
    }
    
    public func convertDateToLocaleString(input: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: input)
    }
}
