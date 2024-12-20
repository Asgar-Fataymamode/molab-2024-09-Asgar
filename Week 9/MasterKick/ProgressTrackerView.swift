//
//  ProgressTrackerView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 14/11/2024.
//


import SwiftUI

struct ProgressTrackerView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                
                //Overall Training Progress
                VStack {
                    Text("Overall Training Progress")
                        .font(.headline)
                    CircularProgressView(progress: 0.75, label: "75% Complete")
                        .frame(width: 150, height: 150)
                        .padding()
                }
                
                Divider()
                
                //Activity Breakdown Section
                VStack(alignment: .leading) {
                    Text("Activity Breakdown")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    HStack(spacing: 20) {
                        CircularProgressView(progress: 0.8, label: "Shooting")
                            .frame(width: 100, height: 100)
                            .padding(.leading, 55)
                        
                        CircularProgressView(progress: 0.65, label: "Passing")
                            .frame(width: 100, height: 100)
                        
                        CircularProgressView(progress: 0.6, label: "Dribbling")
                            .frame(width: 100, height: 100)
                    }
                    .padding(.horizontal, 10)
                }
                
                Divider()
                
                WeeklyActivitySummaryView()
                
                Divider()
                
                SessionInsightsView()
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitle("Progress Tracker", displayMode: .inline)
    }
}

// MARK: - Circular Progress View
struct CircularProgressView: View {
    var progress: CGFloat
    var label: String
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.blue, lineWidth: 10)
                .rotationEffect(.degrees(-90))
                .animation(.easeOut, value: progress)
            
            VStack {
                Text(String(format: "%.0f%%", progress * 100))
                    .font(.title2)
                    .fontWeight(.bold)
                Text(label)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}

// MARK: - Weekly Activity Summary View
struct WeeklyActivitySummaryView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Weekly Activity Summary")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)
            
            HStack(spacing: 15) {
                ForEach(0..<7) { day in
                    WeeklyDayView(day: ["M", "T", "W", "T", "F", "S", "S"][day], trained: day % 2 == 0)
                }
            }
            .padding()
            
            Text("5 out of 7 days trained this week")
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding()
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

// MARK: - Weekly Day View
struct WeeklyDayView: View {
    let day: String
    let trained: Bool
    
    var body: some View {
        VStack {
            Circle()
                .fill(trained ? Color.green : Color.gray.opacity(0.3))
                .frame(width: 40, height: 40)
                .overlay(Text(day)
                            .font(.caption)
                            .foregroundColor(.white))
            
            Text(trained ? "✔︎" : "✘")
                .font(.footnote)
                .foregroundColor(trained ? .green : .gray)
        }
    }
}

// MARK: - Session Insights View
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
            
//            HStack {
//                VStack(alignment: .leading) {
//                    Text("Training Frequency")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                    Text("10 sessions completed this month")
//                        .font(.title3)
//                        .fontWeight(.bold)
//                }
//                Spacer()
//            }
//            .padding(.horizontal, 20)
//            
//            VStack(alignment: .leading) {
//                Text("Skills Learned This Week")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                VStack(alignment: .leading, spacing: 5) {
//                    Text("- Dribbling: Ball Control")
//                    Text("- Shooting: Accuracy")
//                    Text("- Passing: Precision")
//                }
//                .font(.body)
//                .padding(.horizontal, 20)
//            }
        }
        .padding()
//        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

// MARK: - Preview
struct ProgressTrackerView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressTrackerView()
    }
}
