//
//  SessionInsightsView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 06/12/2024.
//
import SwiftUI

struct SessionInsightsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Session Insights")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack {
                VStack {
                    Text("Avg Session")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("45 mins")
                        .font(.title)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack {
                    Text("Calories Burned")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("350 kcal")
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal, 20)
        }
        .padding()
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}
