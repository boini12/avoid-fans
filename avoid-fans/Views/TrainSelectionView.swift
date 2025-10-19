//
//  TrainSelectionView.swift
//  avoid-fans
//
//  Created by Ines Bohr on 11.10.25.
//

import SwiftUI

struct TrainSelectionView: View {
    var journeys: [Journey]
    var dateFormatter = DateConverter()
    
    
    var body: some View {
        List(journeys) { journey in
            JourneyRow(journey: journey)
                .listRowBackground(Color("backgroundColor"))
        }
        .background(Color("backgroundColor"))
        .listRowSeparator(.hidden)
    }
}

#Preview {
    var leg = Leg(departure: Date(), arrival: Date())
    var journey = Journey(legs: [leg])
    var journeys: [Journey] = [journey, journey]
    TrainSelectionView(journeys: journeys)
}

