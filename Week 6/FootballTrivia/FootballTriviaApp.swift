//
//  ClubFootballTriviaView.swift
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/10/2024.
//


import SwiftUI

@main
struct FootballTrivia: App {
    @StateObject var audioDJ = AudioDJ()
    var body: some Scene {
        WindowGroup {
//            ContentView()
            LoginView() // Start with the Login view
                .environmentObject(audioDJ)
        }
    }
}






