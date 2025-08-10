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
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 40){
                Text("Enter your travel details and find out if any fans are taking your train!")
                    .textStyle(HeaderTextStyle())
                    .multilineTextAlignment(.center)
                
                HStack
                {
                    // Origin
                    PickerView(stations: viewModel.getStations(), labelText: "Origin", selectedOptionIndex: $selectedOriginIndex)

                }
                .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
                HStack
                {
                    // Destination
                    PickerView(stations: viewModel.getStations(), labelText: "Destination", selectedOptionIndex: $selectedDestinationIndex)
                }
                .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
                
                // Start date
                DatePicker("Start date",
                        selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                .padding(.init(top: 0, leading: 45, bottom: 0, trailing: 20))
                
                // End date
                DatePicker("End date",
                        selection: $endDate, displayedComponents: [.date, .hourAndMinute])
                .padding(.init(top: 0, leading: 45, bottom: 0, trailing: 20))
                
                Button("Check for crazy fans")
                {
                    let userInput = UserInput(startDate: startDate, endDate: endDate, origin: viewModel.getStations()[selectedOriginIndex], destination: viewModel.getStations()[selectedDestinationIndex])
                    let result = viewModel.validate(input: userInput)
                    
                    if(!result) {
                        return
                    }
                    
                    // Run an async task to make a request to the API
                    Task {
                        do{
                            let matches =  try await apiManager.fetchBundesligaMatches()
                            let controller = APIDataController(matches: matches)
                            let result = controller.checkForMatches(startDate: startDate, endDate: endDate)
                            navigationPath.append(String(result))
                        }catch{
                            // do nothing for now
                        }
                    }
                    
                }.errorAlert(error: $viewModel.error)
                    .buttonStyle(.myPrimaryButtonStyle)
            }
            .navigationDestination(for: String.self) { result in
                ResultView(result: result)
            }
        }.accentColor(Color.primary)
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView()
    }
}
