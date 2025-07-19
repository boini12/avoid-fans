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
    private var userInputController = UserInputController()
    @State private var fansAvoided = false
    @State private var validDates = true
    @State private var validStations = true
    @State private var selectedStartIndex =  0
    @State private var selectedDestinationIndex = 0
    private var stations: [String] = []
    private var apiManager = APIManager()
    
    init() {
        stations = userInputController.getStations()
    }
    
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
            
            Button("Check for crazy fans")
            {
                validDates = userInputController.ValidDates(startDate: startDate, endDate: endDate)
                validStations = userInputController.ValidStations(start: stations[selectedStartIndex], destination: stations[selectedDestinationIndex])
            }
            .padding()
            .task {
                do{
                    var matches =  try await apiManager.fetchBundesligaMatches()
                    var controller = APIDataController(matches: matches)
                    var result = controller.checkForMatches(startDate: startDate, endDate: endDate)
                    print(result)
                }catch{
                    // do nothing for now
                }
            }
            
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
