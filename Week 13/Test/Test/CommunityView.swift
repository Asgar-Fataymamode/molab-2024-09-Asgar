//
//  CommunityView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
//

import SwiftUI

struct CommunityView: View {
    let leaderboardData = [
        LeaderboardEntry(name: "Asgar Fataymamode", score: 1200, timeSpent: "10h 45m"),
        LeaderboardEntry(name: "Lionel Messi", score: 1100, timeSpent: "9h 30m"),
        LeaderboardEntry(name: "Cristiano Ronaldo", score: 1050, timeSpent: "8h 15m"),
        LeaderboardEntry(name: "Diego Maradona", score: 980, timeSpent: "7h 50m"),
        LeaderboardEntry(name: "Zinedine Zidane", score: 950, timeSpent: "7h 20m"),
    ]
    
    var body: some View {
        VStack {
            Text("Community Leaderboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Divider()
            
            List(leaderboardData) { entry in
                HStack {
                    VStack(alignment: .leading) {
                        Text(entry.name)
                            .font(.headline)
                        Text("Time Spent: \(entry.timeSpent)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Text("\(entry.score) pts")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 5)
            }
        }
        .padding(.horizontal)
    }
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let name: String
    let score: Int
    let timeSpent: String
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView()
    }
}
