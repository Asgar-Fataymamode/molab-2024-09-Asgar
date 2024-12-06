//
//  GoalDetailView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 22/11/2024.
//


import SwiftUI

struct GoalDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var updatedProgress: Double
    var goal: Goal
    var onUpdate: (Goal) -> Void

    init(goal: Goal, onUpdate: @escaping (Goal) -> Void) {
        self.goal = goal
        self.onUpdate = onUpdate
        _updatedProgress = State(initialValue: goal.progress)
    }

    var body: some View {
        VStack(spacing: 20) {
            Text(goal.name)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            ProgressView(value: updatedProgress)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .padding(.horizontal, 20)
                .scaleEffect(x: 1, y: 2, anchor: .center)
            
            Text(String(format: "%.0f%% Complete", updatedProgress * 100))
                .font(.title2)
                .foregroundColor(.gray)

            Slider(value: $updatedProgress, in: 0...1, step: 0.01)
                .padding(.horizontal, 20)

            Spacer()
            
            Button(action: {
                var updatedGoal = goal
                updatedGoal.progress = updatedProgress
                onUpdate(updatedGoal)
                dismiss()
            }) {
                Text("Save Progress")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }

            Button(action: {
                dismiss()
            }) {
                Text("Back")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
        }
        .padding()
    }
}
