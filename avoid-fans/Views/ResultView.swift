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
    
    var body: some View {
        VStack {
            Text(viewModel.getResult())
        }
        .onAppear {
            viewModel.fetchMatches(journey: journey)
            viewModel.clashesWithAMatch(journey: journey)
        }
        
    }
       
}
