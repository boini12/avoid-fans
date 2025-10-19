//
//  UserInput.swift
//  avoid-fans
//
//  Created by Ines Bohr on 20.07.25.
//

import Foundation

class UserInput : ObservableObject
{
    let dateFormatter = DateConverter()
    @Published var journeyTimeSelection: JourneyTimeSelection
    @Published var travelDate: Date
    @Published var originIndex : Int
    @Published var destinationIndex: Int
    
    init() {
        self.journeyTimeSelection = JourneyTimeSelection.Arrival
        self.travelDate = Date.now
        self.originIndex = 0
        self.destinationIndex = 1
    }
    
    init(journeyTimeSelection: JourneyTimeSelection, travelDate: Date, originIndex: Int, destinationIndex: Int) {
        self.journeyTimeSelection = journeyTimeSelection
        self.travelDate = travelDate
        self.originIndex = originIndex
        self.destinationIndex = destinationIndex
    }
}
