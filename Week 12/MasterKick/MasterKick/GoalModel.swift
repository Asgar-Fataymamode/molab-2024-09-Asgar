//
//  GoalModel.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 22/11/2024.
//

import SwiftUI


struct Goal: Identifiable {
    let id = UUID()
    var name: String
    var progress: Double
    var isCompleted: Bool
    var completionDate: String?
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
                    .background(Color.green)
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
                .strikethrough(goal.isCompleted, color: .green)
            if let date = goal.completionDate {
                Text("Completed on \(date)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 5)
    }
}
