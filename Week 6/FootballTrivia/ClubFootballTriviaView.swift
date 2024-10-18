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
    TriviaQuestion(question: "Which club plays at the Santiago Bernabéu?", image: "bernabeu", options: ["Real Madrid", "Atletico Madrid", "Barcelona", "Valencia"], correctAnswer: "Real Madrid"),
    
    
    TriviaQuestion(question: "Which English club has won the most Premier League titles?", image: "premierleague", options: ["Manchester United", "Chelsea", "Manchester City", "Arsenal"], correctAnswer: "Manchester United"),
        TriviaQuestion(question: "Who holds the record for the most goals in a single Premier League season?", image: "goals", options: ["Mohamed Salah", "Alan Shearer", "Harry Kane", "Cristiano Ronaldo"], correctAnswer: "Mohamed Salah"),
        TriviaQuestion(question: "Which Italian club is known as The Old Lady?", image: "goals", options: ["AC Milan", "Juventus", "Inter Milan", "Roma"], correctAnswer: "Juventus"),
        TriviaQuestion(question: "Which club won the UEFA Europa League in the 2020-2021 season?", image: "championsleague", options: ["Villarreal", "Manchester United", "Sevilla", "Arsenal"], correctAnswer: "Villarreal"),
        TriviaQuestion(question: "Which club plays at Anfield?", image: "bernabeu", options: ["Liverpool", "Everton", "Tottenham", "Arsenal"], correctAnswer: "Liverpool")
]

struct ClubFootballTriviaView_Previews: PreviewProvider {
    static var previews: some View {
        ClubFootballTriviaView()
    }
}

