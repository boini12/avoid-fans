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
        self.startDate = Date.now
        self.endDate = Date.now
        self.originIndex = 0
        self.destinationIndex = 1
    }
    
}
