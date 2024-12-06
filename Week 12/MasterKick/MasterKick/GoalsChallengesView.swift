//
//  GoalsChallengesView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 14/11/2024.
//



import SwiftUI

struct GoalsChallengesView: View {
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
    @State private var showAddGoalForm = false
    @State private var navigateToSkills = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 20) {
                            Text("Goals & Challenges")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.top, 20)
                            
                            Divider()
                            
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
                            
                            VStack(alignment: .leading, spacing: 10) {
                                Text("Completed Goals")
                                    .font(.headline)
                                
                                ForEach(completedGoals) { goal in
                                    CompletedGoalRowView(goal: goal)
                                }
                            }
                            .padding(.horizontal)
                            
                            Divider()
                            
                            Button(action: {
                                showAddGoalForm = true
                            }) {
                                Text("Add New Goal")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal)
                            
                            Button(action: {
                                withAnimation {
                                    navigateToSkills = true
                                    proxy.scrollTo("skillsSection", anchor: .bottom)
                                }
                            }) {
                                Text("Explore Skills")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal)
                            .id("skillsSection")
                        }
                    }
                    .sheet(isPresented: $showGoalDetails) {
                        if let goal = selectedGoal {
                            GoalDetailView(goal: goal) { updatedGoal in
                                updateGoal(updatedGoal)
                            }
                        }
                    }
                    .sheet(isPresented: $showAddGoalForm) {
                        AddGoalView { newGoal in
                            ongoingGoals.append(newGoal)
                        }
                    }
                    .navigationDestination(isPresented: $navigateToSkills) {
                        SkillListView(skills: skills)
                    }
                }
            }
        }
    }
    
    private func completeGoal(_ goal: Goal) {
        if let index = ongoingGoals.firstIndex(where: { $0.id == goal.id }) {
            var completedGoal = ongoingGoals.remove(at: index)
            completedGoal.isCompleted = true
            completedGoal.completionDate = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .none)
            completedGoals.insert(completedGoal, at: 0)
        }
    }
    
    private func updateGoal(_ updatedGoal: Goal) {
        if let index = ongoingGoals.firstIndex(where: { $0.id == updatedGoal.id }) {
            ongoingGoals[index] = updatedGoal
        }
    }
}



