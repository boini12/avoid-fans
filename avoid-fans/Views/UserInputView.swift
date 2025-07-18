//
//  UserInputView.swift
//  avoid-fans
//
//  Created by Ines on 25.08.23.
//

import SwiftUI

struct UserInputView: View {
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    @State private var userInputController = UserInputController()
    @State private var fansAvoided = false
    @State private var validDates = true
    @State private var validStations = true
    let stations = ["Hamburg", "Hannover", "Munich", "Cologne", "Essen", "Duisburg", "Dresden", "Berlin", "Stuttgard"]
    @State private var selectedStartIndex =  0
    @State private var selectedDestinationIndex = 0
    
    var body: some View {
        VStack{
            HStack
            {
                Spacer(minLength: 0)
                // Starting station
                PickerView(stations: stations, selectedOptionIndex: $selectedStartIndex)
                Spacer(minLength: 0)
            }
            .padding()
            HStack
            {
                Spacer(minLength: 0)
                // Destination
                PickerView(stations: stations, selectedOptionIndex: $selectedDestinationIndex)
                Spacer(minLength: 0)
            }
            
            // Start date
            DatePicker("Start date",
                    selection: $startDate, displayedComponents: [.date, .hourAndMinute])
            .padding()
            
            // End date
            DatePicker("End date",
                    selection: $endDate, displayedComponents: [.date, .hourAndMinute])
            .padding()
            
            // Execute the API check
            Button("Check for crazy fans")
            {
                validDates = userInputController.ValidDates(startDate: startDate, endDate: endDate)
                validStations = userInputController.ValidStations(start: stations[selectedStartIndex], destination: stations[selectedDestinationIndex])
            }
            .padding()
            
            if(!validDates)
            {
                Text("The start data cannot be smaller than the end date.")
            }
            
            if(!validStations)
            {
                Text("The start and destination station cannot be the same.")
            }
        }
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView()
    }
}
