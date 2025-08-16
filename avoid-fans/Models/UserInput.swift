//
//  UserInput.swift
//  avoid-fans
//
//  Created by Ines Bohr on 20.07.25.
//

import Foundation

class UserInput : ObservableObject
{
    let dateFormatter = StringToDateConverter()
    
    @Published var startDate: Date
    @Published var endDate: Date
    @Published var originIndex : Int
    @Published var destinationIndex: Int
    
    init() {
        let now = Date.now
        self.startDate = now
        self.endDate = now
        self.originIndex = 0
        self.destinationIndex = 1
    }
    
    init(startDate: Date, endDate: Date, originIndex: Int, destinationIndex: Int) {
            self.startDate = startDate
            self.endDate = endDate
            self.originIndex = originIndex
            self.destinationIndex = destinationIndex
        }
    
}
