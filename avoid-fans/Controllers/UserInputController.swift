//
//  UserInputController.swift
//  avoid-fans
//
//  Created by Ines on 25.08.23.
//

import UIKit

class UserInputController{
    
    private let dateFormatter = DateFormatter()
    private let date1 = Date.now
    
    
    
    /// Validated the provided dates from the user
    /// - Parameter userInput: User input provided
    /// - Returns: true if the input is valid, false if the input is not valid
    func validateInput(userInput : UserInput) -> Bool{
        let startDate = userInput.startDate
        let endDate = userInput.endDate
        
        if(startDate < endDate){
            return false;
        }
        
        return true;
    }
}
