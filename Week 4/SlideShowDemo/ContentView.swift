//
//  ContentView.swift
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/10/2024.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 15) { // Use VStack for vertical alignment
                Text("Kickoff Trivia")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                   //.padding()
                
                Text("Test Your Football Knowledge")
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)

                
                Spacer()
                
                VStack(spacing: 10) { // Add spacing between Club and International sections
                    VStack {
                        Image("clublevelfootball")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 5)
                        
                        NavigationLink(destination: ClubFootballTriviaView()) {
                            Text("Club Level Trivia")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }

                    VStack {
                        Image("internationalfootball") 
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 250)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 5)
                        
                        NavigationLink(destination: InternationalFootballTriviaView()) {
                            Text("International Level Trivia")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemBackground))
        }
    }
}

// AudioDJ must be established here to avoid crash in preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioDJ())
    }
}
