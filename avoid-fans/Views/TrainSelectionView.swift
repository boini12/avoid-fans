//
//  TrainSelectionView.swift
//  avoid-fans
//
//  Created by Ines Bohr on 11.10.25.
//

import SwiftUI

struct TrainSelectionView: View {
    var journeys: [Journey]
    
    var body: some View {
        List(journeys) { journey in
            NavigationLink(value: journey) {
                JourneyRow(journey: journey)
            }
        }
        .navigationTitle("Train Journeys")
    }
}

#Preview {
    var leg = Leg(departure: Date(), arrival: Date())
    var journey = Journey(legs: [leg])
    var journeys: [Journey] = [journey, journey]
    TrainSelectionView(journeys: journeys)
}

