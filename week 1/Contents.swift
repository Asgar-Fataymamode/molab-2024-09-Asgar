import Foundation

// Initialize the players and teams using arrays as constants
let team1Players = ["Player A", "Player B", "Player C", "Player D", "Player E"]
let team2Players = ["Player F", "Player G", "Player H", "Player I", "Player J"]

// Variables to track team stats
var team1Score = 0
var team2Score = 0
var team1Fouls = 0
var team2Fouls = 0

// Function to display the score
func displayScore() -> String {
    return """
    Team 1        Team 2
      \(team1Score)              \(team2Score)
    """
}

// Function to simulate a goal scored
func simulateGoal(for team: String, players: [String]) -> String {
    let scorer = players[Int.random(in: 0..<players.count)]
    if team == "Team 1" {
        team1Score += 1
    } else {
        team2Score += 1
    }
    let celebration = "\(scorer) celebrates 🏃‍♂️🎉!"
    let scoreUpdate = displayScore()
    return "⚽️ Goal scored by \(scorer) for \(team)!\n\(celebration)\n\n\(scoreUpdate)"
}

// Function to simulate a foul
func simulateFoul(for team: String, players: [String]) -> String {
    let player = players[Int.random(in: 0..<players.count)]
    let foulType = Bool.random() ? "🟡 Yellow Card" : "🔴 Red Card"
    
    if team == "Team 1" {
        team1Fouls += 1
    } else {
        team2Fouls += 1
    }
    
    return "❗ \(player) of \(team) receives a \(foulType)."
}

// Function to simulate the match
func playMatch() {
    let matchEvents = Int.random(in: 8...15)  // Random number of events per match
    print("Football Simulation Match")
    print()
    print("⚽️ Match Start: Team 1 vs Team 2 ⚽️\n")
    
    for _ in 1...matchEvents {
        let eventType = Int.random(in: 1...3) // Randomize event type {1:goal, 2:foul, 3:nothing}
        
        if eventType == 1 {
            let scoringTeam = Bool.random() ? "Team 1" : "Team 2"
            let players = scoringTeam == "Team 1" ? team1Players : team2Players
            print(simulateGoal(for: scoringTeam, players: players))
            print()
        } else if eventType == 2 {
            let foulingTeam = Bool.random() ? "Team 1" : "Team 2"
            let players = foulingTeam == "Team 1" ? team1Players : team2Players
            print(simulateFoul(for: foulingTeam, players: players))
            print()
        } else {
            print("No event occurred this minute.")
            print()
        }
        
        usleep(2000000) //adding delays
    }
    
    //Print final statistics at the end of the match
    print("\n⏱️Match End! Final Score:")
    print(displayScore())
    
    if team1Score > team2Score {
        print("🏆 Team 1 Wins!")
    } else if team2Score > team1Score {
        print("🏆 Team 2 Wins!")
    } else {
        print("🤝 It's a draw!")
    }
}

// Run the match simulation
playMatch()
