//
//  GoalModel.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
//

import SwiftUI

struct Goal: Identifiable {
    let id: UUID
    var name: String
    var progress: Double
    var isCompleted: Bool
    var completionDate: String?
    var userId: String

    init(id: UUID = UUID(), name: String, progress: Double, isCompleted: Bool, completionDate: String? = nil, userId: String) {
        self.id = id
        self.name = name
        self.progress = progress
        self.isCompleted = isCompleted
        self.completionDate = completionDate
        self.userId = userId
    }
}



struct GoalRowView: View {
    var goal: Goal
    var onComplete: () -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(goal.name)
                    .font(.headline)
                ProgressView(value: goal.progress)
                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                    .padding(.vertical, 5)
                Text(String(format: "%.0f%% Complete", goal.progress * 100))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: onComplete) {
                Text("Complete")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black)
                    .cornerRadius(8)
            }
        }
        .padding(.vertical, 5)
    }
}

struct CompletedGoalRowView: View {
    var goal: Goal

    var body: some View {
        VStack(alignment: .leading) {
            Text(goal.name)
                .font(.headline)
                .strikethrough(goal.isCompleted, color: .red)
            if let date = goal.completionDate {
                Text("Completed on \(date)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 5)
    }
}
