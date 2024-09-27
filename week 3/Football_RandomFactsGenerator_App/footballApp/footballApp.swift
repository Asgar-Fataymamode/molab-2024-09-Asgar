//Asgar Fataymamode

import SwiftUI

@main
struct ImageUiDemo_symbolsApp: App {
    var body: some Scene {
        WindowGroup {
            Page0()
        }
    }
}





//


// Declare FootballClub model and array globally
struct FootballClub {
    let name: String
    let factsAndImages: [(fact: String, imageName: String)]
}

import SwiftUI

// Define the football clubs with their facts and images
let footballClubs = [
    FootballClub(name: "Chelsea", factsAndImages: [
        (fact: "Won the Champions League twice", imageName: "chelsea1"),
        (fact: "Have won the Premier League several times", imageName: "chelsea2"),
        (fact: "Stamford Bridge has been their home since 1905", imageName: "chelsea3"),
        (fact: "Roman Abramovich transformed the club", imageName: "chelsea4")
    ]),
    FootballClub(name: "Manchester United", factsAndImages: [
        (fact: "Most Premier League titles", imageName: "manutd1"),
        (fact: "First English team to win the treble", imageName: "manutd2"),
        (fact: "Home of Old Trafford", imageName: "manutd3")
    ]),
    FootballClub(name: "Liverpool", factsAndImages: [
        (fact: "Won 6 Champions League titles", imageName: "liverpool1"),
        (fact: "Ended a 30-year league title drought in 2020", imageName: "liverpool2"),
        (fact: "Anfield's atmosphere is famous", imageName: "liverpool3")
    ]),
    FootballClub(name: "Arsenal", factsAndImages: [
        (fact: "The Invincibles went unbeaten in 2003-04", imageName: "arsenal1"),
        (fact: "Most FA Cup titles with 14 wins", imageName: "arsenal2"),
        (fact: "Moved to Emirates Stadium in 2006", imageName: "arsenal3")
    ])
]




