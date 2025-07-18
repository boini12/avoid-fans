//
//  UserInputController.swift
//  avoid-fans
//
//  Created by Ines on 25.08.23.
//

import UIKit

class UserInputController{
    
    private let dateFormatter = DateFormatter()
    
    func validateInput(startDate: Date, endDate: Date) -> Bool{
        return startDate < endDate;
    }
}
