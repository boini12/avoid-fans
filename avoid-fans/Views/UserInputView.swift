//
//  UserInputView.swift
//  avoid-fans
//
//  Created by Ines on 25.08.23.
//

import SwiftUI

struct UserInputView: View {
    @StateObject var viewModel: UserInputViewModel = UserInputViewModel()
    
    @State private var fansAvoided = false
    @State private var validDates = true
    @State private var validStations = true
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 40){
                Text("Enter your travel details and find out if any fans are taking your train!")
                    .textStyle(HeaderTextStyle())
                    .multilineTextAlignment(.center)
                
                    PickerView(
                        stations: viewModel.getStations(),
                        labelText: String(localized: "Origin"),
                        selectedOptionIndex: $viewModel.userInput.originIndex)

                    PickerView(
                        stations: viewModel.getStations(),
                        labelText: String(localized: "Destination"),
                        selectedOptionIndex: $viewModel.userInput.destinationIndex)

                HStack {
                    Picker("", selection: $viewModel.userInput.journeyTimeSelection) {
                        Text("Departure").tag(JourneyTimeSelection.Departure)
                        Text("Arrival").tag(JourneyTimeSelection.Arrival)
                    }

                    DatePicker("",
                               selection: $viewModel.userInput.travelDate,
                               displayedComponents: [.date, .hourAndMinute])
                }

                Button("Check for crazy fans")
                {
                    let validationResult = viewModel.validate()
                    
                    guard validationResult else { return }
                    Task {
                        let result = try await viewModel.checkIfJourneyExists()
                        
                        navigationPath.append(String(result))
                    }
                }.errorAlert(error: $viewModel.error)
                    .buttonStyle(.myPrimaryButtonStyle)
            }
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
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
