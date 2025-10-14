//
//  JourneyRow.swift
//  avoid-fans
//
//  Created by Ines Bohr on 11.10.25.
//

import SwiftUI

struct JourneyRow: View {
    var journey: Journey
    private let dateFormatter = StringToDateConverter()
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading)
                {
                    Text("Departure:")
                    Text(dateFormatter.convertToString(input: journey.legs.first!.departure!))
                    Text("Arrival:")
                    Text(dateFormatter.convertToString(input: journey.legs.first!.departure!))
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color("primaryColor"), lineWidth: 1))
    }
}

#Preview {
    var leg = Leg(departure: Date(), arrival: Date())
    JourneyRow(journey: .init(legs: [leg]))
}
