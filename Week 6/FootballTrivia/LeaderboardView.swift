//
//  LeaderboardView.swift
//  FootballTrivia
//
//  Created by Muhammad Ali Asgar Fataymamode on 18/10/2024.
//

import SwiftUI

struct LeaderboardView: View {
    @State private var leaderboard: [LeaderboardEntry] = []

    var body: some View {
        VStack {
            Text("Leaderboard")
                .font(.largeTitle)
                .padding()

            List(leaderboard) { entry in
                HStack {
                    Text(entry.username)
                    Spacer()
                    Text("Score: \(entry.score)")
                }
            }
        }
        .onAppear {
            leaderboard = loadLeaderboard()
        }
    }

    // Load leaderboard data from JSON in documents directory
    func loadLeaderboard() -> [LeaderboardEntry] {
        let url = getDocumentsDirectory().appendingPathComponent("leaderboard.json")

        do {
            let data = try Data(contentsOf: url)
            let leaderboard = try JSONDecoder().decode([LeaderboardEntry].self, from: data)
            return leaderboard
        } catch {
            print("Failed to load leaderboard: \(error.localizedDescription)")
            return []
        }
    }

    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

struct LeaderboardEntry: Identifiable, Codable {
    let id = UUID()
    let username: String
    var score: Int
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView()
    }
}



