//
//  UserInputView.swift
//  avoid-fans
//
//  Created by Ines on 25.08.23.
//

import SwiftUI

struct UserInputView: View {
    @StateObject var viewModel = UserInputViewModel()
    
    @State private var startDate = Date.now
    @State private var endDate = Date.now
    @State private var fansAvoided = false
    @State private var validDates = true
    @State private var validStations = true
    @State private var selectedOriginIndex =  0
    @State private var selectedDestinationIndex = 0
    
    private var stations: [String] = []
    private var apiManager = APIManager()
    
    init() {
        stations = viewModel.getStations()
    }
    
    var body: some View {
        VStack{
            HStack
            {
                Spacer(minLength: 0)
                // Origin
                PickerView(stations: stations, selectedOptionIndex: $selectedOriginIndex)
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
                let userInput = UserInput(startDate: startDate, endDate: endDate, origin: stations[selectedOriginIndex], destination: stations[selectedDestinationIndex])
                viewModel.validate(input: userInput)
            }.errorAlert(error: $viewModel.error)
            .padding()
            
            // Run an async task to make a request to the API
            .task {
                do{
                    let matches =  try await apiManager.fetchBundesligaMatches()
                    let controller = APIDataController(matches: matches)
                    let result = controller.checkForMatches(startDate: startDate, endDate: endDate)
                    print(result)
                }catch{
                    // do nothing for now
                }
            }
        }
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView()
    }
}
