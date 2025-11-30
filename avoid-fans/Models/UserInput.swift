//
//  UserInput.swift
//  avoid-fans
//
//  Created by Ines Bohr on 20.07.25.
//

import Foundation

struct UserInput
{
    let dateFormatter = DateConverter()
    var journeyTimeSelection: JourneyTimeSelection
    var travelDate: Date
    var originIndex : Int
    var destinationIndex: Int
    
    init() {
        self.journeyTimeSelection = JourneyTimeSelection.Departure
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
