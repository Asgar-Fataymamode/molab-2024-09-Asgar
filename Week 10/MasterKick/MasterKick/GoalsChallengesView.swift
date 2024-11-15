//
//  GoalsChallengesView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 14/11/2024.
//


import SwiftUI

struct GoalsChallengesView: View {
    //Sample data for ongoing and completed goals
    @State private var ongoingGoals = [
        Goal(name: "Complete 100 Dribbling Drills", progress: 0.4, isCompleted: false),
        Goal(name: "Train 5 Times This Week", progress: 0.75, isCompleted: false),
        Goal(name: "Achieve 1000 Total Points", progress: 0.5, isCompleted: false)
    ]
    
    @State private var completedGoals = [
        Goal(name: "Complete 50 Passing Drills", progress: 1.0, isCompleted: true, completionDate: "Nov 10, 2024"),
        Goal(name: "Train 3 Times This Week", progress: 1.0, isCompleted: true, completionDate: "Nov 7, 2024")
    ]
    
    @State private var selectedGoal: Goal?
    @State private var showGoalDetails = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Goals")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Divider()
            
            //Ongoing Goals Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Ongoing Goals")
                    .font(.headline)
                
                ForEach(ongoingGoals) { goal in
                    GoalRowView(goal: goal, onComplete: {
                        completeGoal(goal)
                    })
                    .onTapGesture {
                        selectedGoal = goal
                        showGoalDetails = true
                    }
                }
            }
            .padding(.horizontal)
            
            Divider()
            
            //Completed Goals Section
            VStack(alignment: .leading, spacing: 10) {
                Text("Completed Goals")
                    .font(.headline)
                
                ForEach(completedGoals) { goal in
                    CompletedGoalRowView(goal: goal)
                }
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .sheet(isPresented: $showGoalDetails) {
            if let goal = selectedGoal {
                GoalDetailView(goal: goal)
            }
        }
        .padding()
    }
    
    //Function to mark a goal as completed and add to completed goals
    private func completeGoal(_ goal: Goal) {
        if let index = ongoingGoals.firstIndex(where: { $0.id == goal.id }) {
            var completedGoal = ongoingGoals.remove(at: index)
            completedGoal.isCompleted = true
            completedGoal.completionDate = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
            completedGoals.insert(completedGoal, at: 0)
        }
    }
}

//Model for Goal
struct Goal: Identifiable {
    let id = UUID()
    var name: String
    var progress: Double
    var isCompleted: Bool
    var completionDate: String?
}

//Row View for Ongoing Goals with "Complete" Button
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
            
            //Complete Button
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

//Row View for Completed Goals
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

//Goal Detail View
struct GoalDetailView: View {
    var goal: Goal
    
    var body: some View {
        VStack(spacing: 20) {
            Text(goal.name)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            
            ProgressView(value: goal.progress)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                .padding(.horizontal, 20)
                .scaleEffect(x: 1, y: 2, anchor: .center)
            
            Text(String(format: "%.0f%% Complete", goal.progress * 100))
                .font(.title2)
                .foregroundColor(.gray)
            
            if goal.isCompleted {
                Text("Goal Completed!")
                    .font(.headline)
                    .foregroundColor(.green)
            }
            
            Spacer()
            
            Button(action: {
                //Code to handle goal updates
            }) {
                Text("Update Progress")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
            }
        }
        .padding()
    }
}

//Preview
struct GoalsChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsChallengesView()
    }
}
