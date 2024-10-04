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

                if gameLost {
                    Text("Game Over!")
                        .font(.title)
                        .foregroundColor(.red)
                        .padding()

                    if showRestartButton {
                        Button(action: restartGame) {
                            Text("Restart")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }

                } else if showCelebration {
                    Text("Congratulations! You've answered all questions correctly!")
                        .font(.title)
                        .foregroundColor(.green)
                        .padding()

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
                            .frame(maxWidth: .infinity, alignment: .leading) // Allow the text to take full width
                            .multilineTextAlignment(.leading) // Align text to the left
                            .lineLimit(nil) // Allow multiple lines
                            .fixedSize(horizontal: false, vertical: true) // Allow text to grow vertically


                        // Display the image from assets before the answers
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

    func startCountdown() {
        countdown = 15
        timerIsRunning = true
        selectedAnswer = nil
        gameLost = false
        showRestartButton = false
        showCelebration = false
    }

    func checkAnswer(selectedAnswer: String) {
        self.selectedAnswer = selectedAnswer
        if let currentQuestion = questions[safe: questionIndex] {
            if selectedAnswer == currentQuestion.correctAnswer {
                correctAnswerSelected = true
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

    func nextQuestion() {
        if questionIndex < questions.count - 1 {
            questionIndex += 1
            startCountdown()
        } else {
            timerIsRunning = false
            showCelebration = true 
        }
    }

    func endGame() {
        timerIsRunning = false
        gameLost = true
        showRestartButton = true
    }

    func restartGame() {
        questionIndex = 0
        startCountdown()
    }

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
