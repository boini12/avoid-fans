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
            .listRowBackground(Color("backgroundColor"))
        }
        .navigationTitle(String(localized: "Train Journeys"))
    }
}

#Preview {
    let leg = Leg(departure: Date(), arrival: Date(), origin: nil, destination: nil, stopovers: [])
    let journey = Journey(legs: [leg])
    let journeys: [Journey] = [journey, journey]
    TrainSelectionView(journeys: journeys)
}

