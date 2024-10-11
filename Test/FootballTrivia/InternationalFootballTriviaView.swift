//
//  InternationalFootballTrivia.swift
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/10/2024.
//
import SwiftUI

struct InternationalFootballTriviaView: View {
    var body: some View {
        TriviaGameView(title: "International Football", questions: internationalFootballQuestions)
    }
}

let internationalFootballQuestions: [TriviaQuestion] = [
    TriviaQuestion(question: "Which country has won the most FIFA World Cups?", image: "brazil", options: ["Germany", "Italy", "Brazil", "Argentina"], correctAnswer: "Brazil"),
    TriviaQuestion(question: "Which player scored the 'Hand of God' goal?", image: "maradona", options: ["Diego Maradona", "Pele", "Ronaldo", "Zidane"], correctAnswer: "Diego Maradona"),
    TriviaQuestion(question: "Which country hosted the 2018 FIFA World Cup?", image: "worldcup2018", options: ["Russia", "Qatar", "Germany", "France"], correctAnswer: "Russia"),
    TriviaQuestion(question: "Who won the Golden Boot in the 2018 FIFA World Cup?", image: "goldenboot", options: ["Harry Kane", "Cristiano Ronaldo", "Luka Modric", "Antoine Griezmann"], correctAnswer: "Harry Kane"),
    TriviaQuestion(question: "Which team won the 2021 Copa America?", image: "copaamerica", options: ["Brazil", "Argentina", "Chile", "Uruguay"], correctAnswer: "Argentina")
]

struct InternationalFootballTriviaView_Previews: PreviewProvider {
    static var previews: some View {
        InternationalFootballTriviaView()
    }
}

