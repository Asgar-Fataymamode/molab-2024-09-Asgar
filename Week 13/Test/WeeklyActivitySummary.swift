//
//  WeeklyActivitySummary.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 06/12/2024.
//
import SwiftUI

struct WeeklyActivitySummaryView: View {
    @Binding var trainedDays: [Bool]
    @Binding var trainingDaysCount: Int

    private let daysOfWeek = ["M", "T", "W", "T", "F", "S", "S"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Weekly Activity Summary")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack(spacing: 15) {
                ForEach(0..<7, id: \.self) { index in
                    WeeklyDayView(day: daysOfWeek[index], trained: trainedDays[index])
                }
            }
            .padding()
            
            Text("\(trainingDaysCount) out of 7 days trained this week")
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}
