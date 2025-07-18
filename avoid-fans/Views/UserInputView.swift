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
    @State private var validUserInputDates = true;
    
    var body: some View {
        VStack{
            DatePicker("Start date",
                    selection: $startDate, displayedComponents: [.date, .hourAndMinute])
            .padding()
            
            DatePicker("End date",
                    selection: $endDate, displayedComponents: [.date, .hourAndMinute])
            .padding()
            
            Button("Check dates")
            {
                validUserInputDates = userInputController.validateInput(startDate: startDate, endDate: endDate)
            }
            
            if(!validUserInputDates)
            {
                Text("The start data cannot be smaller than the end date.")
            }
        }
    }
}

struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView()
    }
}
