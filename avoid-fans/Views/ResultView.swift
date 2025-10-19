//
//  ResultView.swift
//  avoid-fans
//
//  Created by Ines Bohr on 23.07.25.
//

import SwiftUI

struct ResultView: View {
    var viewModel: ResultViewModel = ResultViewModel()
    let journey: Journey
    
    init(journey: Journey) {
        self.journey = journey
        
        viewModel.fetchMatches(journey: journey)
    }
    
    var body: some View {
        
        let result = viewModel.clashesWithAMatch(journey: journey)
        
        if result {
            Text("Your train journey clashes with a football match.")
        }else {
            Text("Your train journey does not clash with a football match.")
        }
    }
}
