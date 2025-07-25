//
//  UserInputViewModelTests.swift
//  Unit Tests for the UserInputViewModel
//
//  Created by Ines Bohr on 20.07.25.
//

@testable import avoid_fans
import Testing
import Foundation

struct UserInputViewModelTests {

    @Test func validateSameDateEntered() {
        // Arrange
        let testInstance = UserInputViewModel()
        let inputStub = createUserInputMock(sameDate: true, sameStation: false)
        
        // Act
        let result = testInstance.validate(input: inputStub)
        
        // Assert
        let error = testInstance.error as? ValidationError
        #expect(error?.errorType == ValidationErrorType.invalidDate)
        #expect(result == false)
    }
    
    @Test func validateSameStationEntered() {
        // Arrange
        let testInstance = UserInputViewModel()
        let inputStub = createUserInputMock(sameDate: false, sameStation: true)
        
        // Act
        let result = testInstance.validate(input: inputStub)
        
        // Assert
        let error = testInstance.error as? ValidationError
        #expect(error?.errorType == ValidationErrorType.invalidStation)
        #expect(result == false)
    }
    
    @Test func validateValidInputEntered() {
        // Arrange
        let testInstance = UserInputViewModel()
        let inputStub = createUserInputMock(sameDate: false, sameStation: false)
        
        // Act
        let result = testInstance.validate(input: inputStub)
        
        // Assert
        let error = testInstance.error as? ValidationError
        #expect(error == nil)
        #expect(result == true)
    }
    
    // This is just a temporary test and will be replaced when the getStations()
    // logic has been changed
    @Test func generateStations() {
        // Arrange
        let testInstance = UserInputViewModel()
        
        // Act
        let stations = testInstance.getStations()
        
        // Assert
        #expect(stations.count > 0)
    }
    
    private func createUserInputMock(sameDate: Bool, sameStation: Bool) -> UserInput {
        let startDate = createDate(year: 2025, month: 07, day: 14, hour: 3, minute: 25)
        let endDate = createDate(year: 2025, month: 07, day: 20, hour: 4, minute: 13)
        
        let origin = "Hamburg"
        let destination = "Berlin"
        
        if (sameDate) {
            return UserInput(startDate: startDate!, endDate: startDate!, origin: origin, destination: destination)
        }
        
        if (sameStation) {
            return UserInput(startDate: startDate!, endDate: endDate!, origin: origin, destination: origin)
        }
        
        return UserInput(startDate: startDate!, endDate: endDate!, origin: origin, destination: destination)
    }
    
    private func createDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date? {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        return Calendar.current.date(from: components)
    }

}
