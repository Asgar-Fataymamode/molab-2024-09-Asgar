


import SwiftUI

struct ContentView: View {
    
    @AppStorage("username") var username: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    
    
    
    
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Gifts Icon at the top right
//                HStack {
//                    Spacer()
//                    
//                    NavigationLink(destination: AchievementsPageView()) {
//                        Image(systemName: "gift.fill")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//                            .padding()
//                        
//                        
//                        Text("Welcome, \(username)!")
//                            .font(.title2)
//                            .fontWeight(.medium)
//
//                        Spacer()
//
//                        Button(action: {
//                            username = "" // Clear username to log out
//                            presentationMode.wrappedValue.dismiss() // Dismiss back to login
//                        }) {
//                            Text("Logout")
//    //                            .frame(maxWidth: .infinity)
//                                .padding()
//                                .background(Color.red)
//                                .foregroundColor(.white)
//                                .cornerRadius(8)
//                        }
//                    }
//                    }
//                    .padding(.trailing, 20)
//                }
                HStack {
                    // Welcome message first
                    Text("User: \(username)")
                        .font(.title2)
                        .fontWeight(.medium)

                    Spacer() // Spacer between welcome message and gift icon

                    // Gift icon second
                    NavigationLink(destination: AchievementsPageView()) {
                        Image(systemName: "gift.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .padding()
                    }

                    Spacer() // Spacer between gift icon and logout button

                    // Logout button third
                    Button(action: {
                        username = "" // Clear username to log out
                        presentationMode.wrappedValue.dismiss() // Dismiss back to login
                    }) {
                        Text("Logout")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 20)

                
                // Display Username and Logout Option
//                HStack {
//                    Text("Welcome, \(username)!")
//                        .font(.title2)
//                        .fontWeight(.medium)
//
//                    Spacer()
//
//                    Button(action: {
//                        username = "" // Clear username to log out
//                        presentationMode.wrappedValue.dismiss() // Dismiss back to login
//                    }) {
//                        Text("Logout")
////                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.red)
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                    }
//                }
//                .padding()

                
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
                VStack(spacing: 0) { //  spacing between Club and International sections
                    VStack {
                        
                        // Add the Leaderboard Button
                        NavigationLink(destination: LeaderboardView()) {
                            Text("Leaderboard")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        
                        
                        
                        
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
                }
                
//                // Add the Leaderboard Button
//                NavigationLink(destination: LeaderboardView()) {
//                    Text("Leaderboard")
//                        .padding()
//                        .background(Color.orange)
//                        .foregroundColor(.white)
//                        .cornerRadius(8)
//                }


                Spacer() // Spacer at the bottom for consistent vertical alignment
            }
            .padding()
            .background(Color(UIColor.systemBackground)).navigationBarBackButtonHidden(true)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AudioDJ())
    }
}
