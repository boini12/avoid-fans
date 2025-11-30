//
//  JourneyRow.swift
//  avoid-fans
//
//  Created by Ines Bohr on 11.10.25.
//

import SwiftUI

struct JourneyRow: View {
    var journey: Journey
    private let dateFormatter = DateConverter()
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading)
                {
                    Text("Departure from: \(journey.legs.first!.origin!.name)")
                        .bold()
                    Text(dateFormatter.convertDateToLocaleString(input: journey.legs.first!.departure!))
                    Text("Arrival at: \(journey.legs.last!.destination!.name)")
                        .bold()
                    Text(dateFormatter.convertDateToLocaleString(input: journey.legs.last!.arrival!))
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color("primaryColor"), lineWidth: 1))
    }
}

#Preview {
    let leg = Leg(departure: Date(), arrival: Date(), origin: nil, destination: nil, stopovers: [])
    JourneyRow(journey: .init(legs: [leg]))
}
