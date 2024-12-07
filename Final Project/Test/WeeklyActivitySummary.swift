////
////  WeeklyActivitySummary.swift
////  Test
////
////  Created by Muhammad Ali Asgar Fataymamode on 06/12/2024.
////
import SwiftUI

struct WeeklyActivitySummaryView: View {
    let trainedDays: [String]

    private let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Weekly Activity Summary")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)

            HStack(spacing: 15) {
                ForEach(daysOfWeek, id: \.self) { day in
                    WeeklyDayView(day: day.prefix(1).uppercased(), trained: trainedDays.contains(day))
                }
            }
            .padding()

            Text("To train \(trainedDays.count) out of 7 days this week")
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

struct WeeklyDayView: View {
    let day: String
    let trained: Bool

    var body: some View {
        VStack {
            Circle()
                .fill(trained ? Color.blue : Color.gray.opacity(0.3))
                .frame(width: 40, height: 40)
                .overlay(Text(day)
                            .font(.caption)
                            .foregroundColor(.white))

            Text(trained ? "✔︎" : "✘")
                .font(.footnote)
                .foregroundColor(trained ? .black : .gray)
        }
    }
}
