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
                
                HStack
                {
                    // Origin
                    PickerView(stations: viewModel.getStations(), labelText: String(localized: "Origin"), selectedOptionIndex: $viewModel.userInput.originIndex)

                }
                .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
                HStack
                {
                    // Destination
                    PickerView(stations: viewModel.getStations(), labelText: String(localized: "Destination"), selectedOptionIndex: $viewModel.userInput.destinationIndex)
                }
                .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
                
                // Start date
                DatePicker("Departure",
                           selection: $viewModel.userInput.startDate, displayedComponents: [.date, .hourAndMinute])
                .padding(.init(top: 0, leading: 45, bottom: 0, trailing: 20))
                
                // End date
                DatePicker("Arrival",
                           selection: $viewModel.userInput.endDate, displayedComponents: [.date, .hourAndMinute])
                .padding(.init(top: 0, leading: 45, bottom: 0, trailing: 20))
                
                Button("Check for crazy fans")
                {
                    let validationResult = viewModel.validate()
                    
                    guard validationResult else { return }

                    Task {
                        let result = try await viewModel.checkForFans()
                        
                        navigationPath.append(String(result))
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
