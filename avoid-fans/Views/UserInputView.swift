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
    @State private var matchDateController = MatchDateCheckController()
    @State private var fansAvoided = false
    @State private var datesChecked = false
    @State private var matches : [Match] = []
    
    var body: some View {
        VStack{
            DatePicker("Startdate",
                    selection: $startDate, displayedComponents: [.date, .hourAndMinute])
            .padding()
            
            DatePicker("Enddate",
                    selection: $endDate, displayedComponents: [.date, .hourAndMinute])
            .padding()
            
            Button("Check dates"){
                let userInput = UserInput(startDate: startDate, endDate: endDate)
                if(!userInputController.validateInput(userInput: userInput)){
                    print("Error: Dates entered not valid")
                }
                
                // Fetch matches
                FootballDataService.shared.getBundesligaMatches { result in
                    switch result {
                    case .success(let matches):
                        DispatchQueue.main.async {
                            self.matches = matches
                        }
                    case .failure(let error):
                        print("Error fetching matches: \(error.localizedDescription)")
                    }
                }
                
                fansAvoided = matchDateController.checkForMatchOnDate(userInput: userInput, matches: matches)
                datesChecked = true
            }
            
            if datesChecked {
               ResultView(fansAvoided: fansAvoided)
           }
        }
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView()
    }
}
