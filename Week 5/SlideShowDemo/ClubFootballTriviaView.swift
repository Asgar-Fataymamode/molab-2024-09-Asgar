//
//  ClubFootballTriviaView.swift
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/10/2024.
//

import SwiftUI

struct ClubFootballTriviaView: View {
    var body: some View {
        TriviaGameView(title: "Club Football", questions: clubFootballQuestions)
    }
}

let clubFootballQuestions: [TriviaQuestion] = [
    TriviaQuestion(question: "Which club has won the most UEFA Champions League titles?", image: "championsleague", options: ["Real Madrid", "Barcelona", "Liverpool", "AC Milan"], correctAnswer: "Real Madrid"),
    TriviaQuestion(question: "Which player has the most Ballon d'Or awards?", image: "goals", options: ["Cristiano Ronaldo", "Lionel Messi", "Neymar", "Luka Modric"], correctAnswer: "Lionel Messi"),
    TriviaQuestion(question: "Which club is known as The Red Devils?", image: "manu", options: ["Manchester United", "Liverpool", "Arsenal", "Chelsea"], correctAnswer: "Manchester United"),
    TriviaQuestion(question: "Which club won the Premier League in the 2015-2016 season?", image: "premierleague", options: ["Leicester City", "Manchester City", "Chelsea", "Tottenham"], correctAnswer: "Leicester City"),
    TriviaQuestion(question: "Which club plays at the Santiago Bernabéu?", image: "bernabeu", options: ["Real Madrid", "Atletico Madrid", "Barcelona", "Valencia"], correctAnswer: "Real Madrid")
]

struct ClubFootballTriviaView_Previews: PreviewProvider {
    static var previews: some View {
        ClubFootballTriviaView()
    }
}

