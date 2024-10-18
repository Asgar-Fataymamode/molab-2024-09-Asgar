//
//  TriviaGameView.swift
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/10/2024.
//

import SwiftUI

struct TriviaGameView: View {
    @State var questionIndex = 0
    @State var countdown = 15
    @State var timerIsRunning = false
    @State var gameLost = false
    @State var correctAnswerSelected = false
    @State var selectedAnswer: String? = nil
    @State var showRestartButton = false
    @State var showCelebration = false
    
    // Track current score
    @State var currentScore = 0
    
    // Track newly unlocked achievements
    @State var achievementsUnlocked: [String] = []
        
    // High score for Club level
    @AppStorage("clubHighScore") var clubHighScore = 0
    
    // High score for International level
    @AppStorage("internationalHighScore") var internationalHighScore = 0
    
    // Track the start time for each question
    @State var startTime: Date?
    
    // Check if each question is answered under the time threshold
    @State var timeThreshold: Bool = true
        
    // Achievements
    @AppStorage("clubPerfectScore") var clubPerfectScore = false
    @AppStorage("internationalPerfectScore") var internationalPerfectScore = false
    @AppStorage("solvedWithin10Seconds") var solvedWithin10Seconds = false
    @AppStorage("solvedWithin5Seconds") var solvedWithin5Seconds = false

    
    @AppStorage("username") var username: String = ""

    
    
    @Environment(\.presentationMode) var presentationMode

    let title: String
    let questions: [TriviaQuestion]

    // Timer that runs every second
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            VStack {
                Text(title)
                    .font(.largeTitle)
                    .padding()
                
                
                
                // Display Current Score
                Text("Score: \(currentScore)")
                    .font(.headline)
                    .padding()
                                
                                // Display High Score
//                                if title == "Club Football" {
//                                    Text("High Score: \(clubHighScore)")
//                                        .font(.headline)
//                                        .foregroundColor(.blue)
//                                        .padding()
//                                } else if title == "International Football" {
//                                    Text("High Score: \(internationalHighScore)")
//                                        .font(.headline)
//                                        .foregroundColor(.green)
//                                        .padding()
//                                }


                if gameLost {
                    Text("Game Over!")
                        .font(.title)
                        .foregroundColor(.red)
                        .padding()
                    displayAchievements()
                    
                    if title == "Club Football" {
                        Text("High Score: \(clubHighScore)")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                    } else if title == "International Football" {
                        Text("High Score: \(internationalHighScore)")
                            .font(.headline)
                            .foregroundColor(.green)
                            .padding()
                    }
                    

                    if showRestartButton {
                        Button(action: restartGame) {
                            Text("Restart")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }

                }
                

                else if showCelebration {
                    Text("Congratulations! You've answered all questions correctly!")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding()
                    displayAchievements()

                    Button(action: restartGame) {
                        Text("Play Again")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                } else {
                    if let currentQuestion = questions[safe: questionIndex] {
//                        Text(currentQuestion.question)
//                            .font(.title2)
//                            .multilineTextAlignment(.center)
//                            .padding()
//                            .lineLimit(nil)
                        Text(currentQuestion.question)
                            .font(.title2)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)


                        Image(currentQuestion.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .padding()

                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(currentQuestion.options, id: \.self) { option in
                                Button(action: {
                                    checkAnswer(selectedAnswer: option)
                                }) {
                                    HStack {
                                        Text(option)
                                            .padding()
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .background(selectedAnswer == option ? answerBackgroundColor(for: option) : Color.gray.opacity(0.2))
                                    .foregroundColor(.black)
                                    .cornerRadius(8)
                                }
                            }
                        }
                        .padding(.horizontal)

                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(clockColor)
                            Text("Time Remaining: \(countdown)")
                                .font(.headline)
                                .foregroundColor(clockColor)
                        }
                        .padding()
                    }
                }
            }

            if showCelebration {
                ConfettiView()
            }
            
            
        }
        .onAppear {
//            resetHighScoreIfNeeded()
            startCountdown()
        }
        .onReceive(timer) { _ in
            if timerIsRunning {
                if countdown > 0 {
                    countdown -= 1
                } else {
                    endGame()
                }
            }
        }
    }

//    func startCountdown() {
//        countdown = 15
//        timerIsRunning = true
//        selectedAnswer = nil
//        gameLost = false
//        showRestartButton = false
//        showCelebration = false
//        
//        
//        startTime = Date() // Start tracking time for each question
//    }
    
    func startCountdown() {
        countdown = 15
        timerIsRunning = true
        selectedAnswer = nil
        gameLost = false
        showRestartButton = false
        showCelebration = false
        
        //Reset achievements for time thresholds at the start of the game
        solvedWithin5Seconds = true
        solvedWithin10Seconds = true
        
        // Reset time threshold
        timeThreshold = true
        
        // Start tracking time for each question
        startTime = Date()
    }


//    func checkAnswer(selectedAnswer: String) {
//        self.selectedAnswer = selectedAnswer
//        if let currentQuestion = questions[safe: questionIndex] {
//            
//            let timeTaken = Date().timeIntervalSince(startTime ?? Date())
//            
//            if selectedAnswer == currentQuestion.correctAnswer {
//                correctAnswerSelected = true
//                currentScore += 1 // Increment score for correct answer
//                
//                // Check if answer was within time limits
//                if timeTaken > 10 {
//                    timeThreshold = false // Not within 10-second limit
//                } else if timeTaken > 5 {
//                    solvedWithin5Seconds = false
//                }
//                
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    nextQuestion()
//                }
//            } else {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    endGame()
//                }
//            }
//        }
//    }
    
    func checkAnswer(selectedAnswer: String) {
        self.selectedAnswer = selectedAnswer
        if let currentQuestion = questions[safe: questionIndex] {
            let timeTaken = Date().timeIntervalSince(startTime ?? Date())
            
            if selectedAnswer == currentQuestion.correctAnswer {
                correctAnswerSelected = true
                currentScore += 1  // Increment score for correct answer
                
                // Check if the answer was within the required time limits
                if timeTaken > 10 {
                    solvedWithin10Seconds = false  // Disable achievement if more than 10 seconds
                }
                if timeTaken > 5 {
                    solvedWithin5Seconds = false  // Disable achievement if more than 5 seconds
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    nextQuestion()
                }
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    endGame()
                }
            }
        }
    }

//    func checkAnswer(selectedAnswer: String) {
//        self.selectedAnswer = selectedAnswer
//        if let currentQuestion = questions[safe: questionIndex] {
//            let timeTaken = Date().timeIntervalSince(startTime ?? Date())
//            
//            if selectedAnswer == currentQuestion.correctAnswer {
//                correctAnswerSelected = true
//                
//                // Increment score for correct answer
//                currentScore += 1
//                
//                // Check if the answer was within time limits
//                if timeTaken > 10 {
//                    // Disable the 10s achievement
//                    solvedWithin10Seconds = false
//                }
//                if timeTaken > 5 {
//                    // Disable the 5s achievement
//                    solvedWithin5Seconds = false
//                }
//                
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    nextQuestion()
//                }
//            } else {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                    endGame()
//                }
//            }
//        }
//    }


    func nextQuestion() {
        if questionIndex < questions.count - 1 {
            questionIndex += 1
            startCountdown()
        } else {
            timerIsRunning = false
            showCelebration = true
            updateHighScore()
            
            checkAchievements()
            // Stop timer when game completes
            timer.upstream.connect().cancel()
        }
    }

    func endGame() {
        timerIsRunning = false
        gameLost = true
        showRestartButton = true
        updateHighScore()
        
        
        
        
        saveScoreToLeaderboard()
        
        
        
        
        
        
        // Stop timer when game ends
        timer.upstream.connect().cancel()
    }

    func restartGame() {
        saveScoreToLeaderboard()
        questionIndex = 0
        // Reset score when game starts
        currentScore = 0
        startCountdown()
    }
    
    
    // Check for achievements
//       func checkAchievements() {
//           if title == "Club Football" && currentScore == questions.count {
//               clubPerfectScore = true // Unlock perfect score achievement for Club
//               achievementsUnlocked.append("🏆 Perfect Club Score!")
//           } else if title == "International Football" && currentScore == questions.count {
//               internationalPerfectScore = true // Unlock perfect score achievement for International
//               achievementsUnlocked.append("🏆 Perfect International Score!")
//           }
//           
//           if timeThreshold {
//               if solvedWithin10Seconds == false && currentScore == questions.count {
//                   solvedWithin10Seconds = true // Unlock time achievement for solving within 10 seconds
//                   achievementsUnlocked.append("⏱️ Solved All Questions Under 10 Seconds!")
//               }
//               if solvedWithin5Seconds == false && currentScore == questions.count {
//                   solvedWithin5Seconds = true // Unlock better time achievement for solving within 5 seconds
//                   achievementsUnlocked.append("⚡ Solved All Questions Under 5 Seconds!")
//               }
//           }
//       }
//    func checkAchievements() {
//        if title == "Club Football" && currentScore == questions.count {
//            clubPerfectScore = true
//            achievementsUnlocked.append("🏆 Perfect Club Score!")
//        } else if title == "International Football" && currentScore == questions.count {
//            internationalPerfectScore = true
//            achievementsUnlocked.append("🏆 Perfect International Score!")
//        }
//
//        if solvedWithin10Seconds && currentScore == questions.count {
//            achievementsUnlocked.append("⏱️ Solved All Questions Under 10 Seconds!")
//        }
//        if solvedWithin5Seconds && currentScore == questions.count {
//            achievementsUnlocked.append("⚡ Solved All Questions Under 5 Seconds!")
//        }
//    }
    func checkAchievements() {
        // Check if the player has achieved a perfect score
        if title == "Club Football" && currentScore == questions.count {
            clubPerfectScore = true
            achievementsUnlocked.append("🏆 Perfect Club Score!")
        }
        
        // Check if the player solved all questions under time constraints
        if solvedWithin10Seconds && currentScore == questions.count {
            solvedWithin10Seconds = true
            achievementsUnlocked.append("⏱️ Solved All Questions Under 10 Seconds!")
        }
        
        if solvedWithin5Seconds && currentScore == questions.count {
            solvedWithin5Seconds = true
            achievementsUnlocked.append("⚡ Solved All Questions Under 5 Seconds!")
        }

        // Persist the unlocked achievements in @AppStorage
        saveAchievements()
    }
    
    
    func saveAchievements() {
        // AppStorage will automatically persist these values; no need to manually save
        // However, we could include additional logic if necessary to handle achievement saving
    }



       func displayAchievements() -> some View {
           VStack {
               ForEach(achievementsUnlocked, id: \.self) { achievement in
                   Text(achievement)
                       .font(.headline)
                       .padding()
               }
           }
       }
    
    
    
//    // Update High Score
//        func updateHighScore() {
//            if title == "Club Football" && currentScore > clubHighScore {
//                clubHighScore = currentScore
//            } else if title == "International Football" && currentScore > internationalHighScore {
//                internationalHighScore = currentScore
//            }
//        }
    func updateHighScore() {
        if title == "Club Football" {
            let cappedScore = min(currentScore, 10)
            if cappedScore > clubHighScore {
                clubHighScore = cappedScore
            }
        } else if title == "International Football" {
            let cappedScore = min(currentScore, 5)
            if cappedScore > internationalHighScore {
                internationalHighScore = cappedScore
            }
        }
    }

    
//    func resetHighScoreIfNeeded() {
//        if title == "Club Football" {
//            clubHighScore = 0 // Reset the club high score to zero
//        }
//    }
    
//

    
    // Save score to leaderboard
    // Save score to leaderboard
    func saveScoreToLeaderboard() {
        let newEntry = LeaderboardEntry(username: username, score: currentScore)

        // Load existing leaderboard
        var leaderboard = loadLeaderboard()

        // Check if the username already exists in the leaderboard
        if let existingIndex = leaderboard.firstIndex(where: { $0.username == username }) {
            // Update the score regardless of whether it's higher or lower
            leaderboard[existingIndex].score = currentScore
        } else {
            // Add new entry if the username doesn't exist in the leaderboard
            leaderboard.append(newEntry)
        }

        // Save leaderboard back to file
        let url = getDocumentsDirectory().appendingPathComponent("leaderboard.json")
        do {
            let data = try JSONEncoder().encode(leaderboard)
            try data.write(to: url)
        } catch {
            print("Failed to save leaderboard: \(error.localizedDescription)")
        }
    }



    
//        func loadLeaderboard() -> [LeaderboardEntry] {
//            let url = getDocumentsDirectory().appendingPathComponent("leaderboard.json")
//            do {
//                let data = try Data(contentsOf: url)
//                let leaderboard = try JSONDecoder().decode([LeaderboardEntry].self, from: data)
//                return leaderboard
//            } catch {
//                print("Failed to load leaderboard: \(error.localizedDescription)")
//                return []
//            }
//        }
    
    func loadLeaderboard() -> [LeaderboardEntry] {
        let url = getDocumentsDirectory().appendingPathComponent("leaderboard.json")
        do {
            let data = try Data(contentsOf: url)
            var leaderboard = try JSONDecoder().decode([LeaderboardEntry].self, from: data)
            
            // Sort leaderboard in descending order by score
            leaderboard.sort { $0.score > $1.score }
            
            return leaderboard
        } catch {
            print("Failed to load leaderboard: \(error.localizedDescription)")
            return []
        }
    }


        func getDocumentsDirectory() -> URL {
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        }
    
    
    
    
    
    
    
    
    
    
//

    
    

    func answerBackgroundColor(for answer: String) -> Color {
        if let currentQuestion = questions[safe: questionIndex] {
            return answer == currentQuestion.correctAnswer ? Color.green : Color.red
        }
        return Color.gray
    }

    var clockColor: Color {
        switch countdown {
        case 11...20:
            return Color.green
        case 6...10:
            return Color.orange
        default:
            return Color.red
        }
    }
}


struct ConfettiView: View {
    @State private var animationActive = false

    var body: some View {
        ZStack {
            ForEach(0..<20) { _ in
                Circle()
                    .fill(randomColor())
                    .frame(width: 10, height: 10)
                    .position(
                        x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                        y: animationActive ? CGFloat.random(in: 0...UIScreen.main.bounds.height) : -50
                    )
                    .animation(
                        .easeOut(duration: 2.0)
                            .repeatForever(autoreverses: false)
                            .delay(Double.random(in: 0...1)),
                        value: animationActive
                    )
            }
        }
        .onAppear {
            animationActive = true
        }
    }

    
    func randomColor() -> Color {
        let colors: [Color] = [.red, .blue, .green, .yellow, .pink, .orange, .purple]
        return colors.randomElement() ?? .white
    }
}




struct TriviaQuestion {
    var question: String
    var image: String
    var options: [String]
    var correctAnswer: String
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
