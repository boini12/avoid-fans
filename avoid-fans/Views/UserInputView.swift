//
//  UserInputView.swift
//  avoid-fans
//
//  Created by Ines on 25.08.23.
//

import SwiftUI

struct UserInputView: View {
    @ObservedObject var viewModel: UserInputViewModel
    @ObservedObject var userInput: UserInput
    @State private var navigationPath = NavigationPath()
    
    init(viewModel: UserInputViewModel = UserInputViewModel()) {
        self.viewModel = viewModel
        self.userInput = viewModel.userInput
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 60){
                Text("Enter your travel details and find out if any fans are taking your train!")
                    .textStyle(HeaderTextStyle())
                    .multilineTextAlignment(.center)
        
                ZStack {
                    Button(action: viewModel.switchOriginAndDestination){
                        Label("", systemImage: "arrow.up.arrow.down")
                            .frame(width:30, height:30)
                            .scaledToFit()
                    }
                    .offset(x: 175, y: 0)
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.circle)
                    .tint(Color("primaryColor"))
                    .foregroundStyle(.white)
                
                    VStack(spacing: 20) {
                        PickerView(
                            stations: viewModel.getStations(),
                            labelText: String(localized: "Origin"),
                            selectedOptionIndex: $viewModel.userInput.originIndex)
                    
                        PickerView(
                            stations: viewModel.getStations(),
                            labelText: String(localized: "Destination"),
                            selectedOptionIndex: $viewModel.userInput.destinationIndex)
                    }
                }
                    
                HStack {
                    Picker("", selection: $viewModel.userInput.journeyTimeSelection) {
                        Text("Departure").tag(JourneyTimeSelection.Departure)
                        Text("Arrival").tag(JourneyTimeSelection.Arrival)
                    }

                    DatePicker("",
                               selection: $viewModel.userInput.travelDate,
                               displayedComponents: [.date, .hourAndMinute])
                
                }
                

                Button(String(localized: "Find train journeys"))
                {
                    guard viewModel.validate() else { return }
                    
                    Task {
                        do {
                            let result = try await viewModel.findJourneys();
                            navigationPath.append(result)
                        }catch {
                            viewModel.error = error
                        }
                    }
                }.errorAlert(error: $viewModel.error)
                    .buttonStyle(.myPrimaryButtonStyle)
            }
            .padding(.init(top: 0, leading: 15, bottom: 0, trailing: 15))
            .navigationDestination(for: [Journey].self) { journeys in
                TrainSelectionView(journeys: journeys)
            }
            .navigationDestination(for: Journey.self) { journey in
                ResultView(path: $navigationPath, journey: journey)
            }
        }.accentColor(Color.primary)
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView()
    }
}
