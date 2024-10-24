////
////  ContentView.swift
////
////  Created by Muhammad Ali Asgar Fataymamode on 04/10/2024.
////
//
//import SwiftUI
//
//
//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            
//            HStack {
//                Spacer()
//                
//                // Gifts Icon to navigate to achievements page
//                NavigationLink(destination: AchievementsPageView()) {
//                    Image(systemName: "gift.fill")
//                        .resizable()
//                        .frame(width: 40, height: 40)
//                        .padding()
//                }
//                .padding(.trailing, 20)
//            }
//
//            
//            
//            
//            VStack(spacing: 15) { // Use VStack for vertical alignment
//                Text("Kickoff Trivia")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                   //.padding()
//                
//                Text("Test Your Football Knowledge")
//                    .font(.title3)
//                    .fontWeight(.medium)
//                    .multilineTextAlignment(.center)
//                    .padding(.bottom, 5)
//
//                
//                Spacer()
//                
//                VStack(spacing: 10) { // Add spacing between Club and International sections
//                    VStack {
//                        Image("clublevelfootball")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 250, height: 250)
//                            .clipShape(RoundedRectangle(cornerRadius: 15))
//                            .shadow(radius: 5)
//                        
//                        NavigationLink(destination: ClubFootballTriviaView()) {
//                            Text("Club Level Trivia")
//                                .font(.headline)
//                                .multilineTextAlignment(.center)
//                                .padding()
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(8)
//                        }
//                    }
//
//                    VStack {
//                        Image("internationalfootball") 
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 250, height: 250)
//                            .clipShape(RoundedRectangle(cornerRadius: 15))
//                            .shadow(radius: 5)
//                        
//                        NavigationLink(destination: InternationalFootballTriviaView()) {
//                            Text("International Level Trivia")
//                                .font(.headline)
//                                .multilineTextAlignment(.center)
//                                .padding()
//                                .background(Color.green)
//                                .foregroundColor(.white)
//                                .cornerRadius(8)
//                        }
//                    }
//                }
//                
//                Spacer()
//            }
//            .padding()
//            .background(Color(UIColor.systemBackground))
//        }
//    }
//}
//
//// AudioDJ must be established here to avoid crash in preview
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(AudioDJ())
//    }
//}


import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 15) {
                // Gifts Icon at the top right
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: AchievementsPageView()) {
                        Image(systemName: "gift.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding()
                    }
                    .padding(.trailing, 20)
                }
                
                // Main Title
                Text("Kickoff Trivia")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                // Subtitle
                Text("Test Your Football Knowledge")
                    .font(.title3)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 5)

                Spacer()

                // Club and International Trivia Sections
                VStack(spacing: 10) { //  spacing between Club and International sections
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

                Spacer() // Spacer at the bottom for consistent vertical alignment
            }
            .padding()
            .background(Color(UIColor.systemBackground))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioDJ())
    }
}
