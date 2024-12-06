//
//  HomePageView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 14/11/2024.

//import SwiftUI
//
//struct HomePageView: View {
//    @State private var isGetStartedClicked = false
//
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 20) {
//                Text("MasterKick")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .padding(.top, 50)
//
//                Text("Master Every Kick, Reach Every Goal")
//                    .font(.headline)
//                    .foregroundColor(.blue)
//
//                Spacer()
//
//                if !isGetStartedClicked {
//                    //Get Started Button
//                    Button(action: {
//                        isGetStartedClicked = true
//                    }) {
//                        Text("Get Started")
//                            .font(.title2)
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(Color.black)
//                            .cornerRadius(10)
//                    }
//                    .padding(.horizontal, 30)
//                } else {
//                    //Sign In and Sign Up Buttons
//                    VStack(spacing: 15) {
//                        NavigationLink(destination: SignInView()) {
//                            Text("Sign In")
//                                .font(.title2)
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.blue)
//                                .cornerRadius(10)
//                        }
//                        .padding(.horizontal, 30)
//
//                        NavigationLink(destination: SignUpView()) {
//                            Text("Sign Up")
//                                .font(.title2)
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.green)
//                                .cornerRadius(10)
//                        }
//                        .padding(.horizontal, 30)
//                        
//                        NavigationLink(destination: DashboardView()) {
//                            Text("Dashboard (For Testing)")
//                                .font(.title2)
//                                .foregroundColor(.white)
//                                .padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.gray)
//                                .cornerRadius(10)
//                        }
//                        .padding(.horizontal, 30)
//                    }
//                }
//
//                Spacer()
//            }
//            .padding()
//            .navigationBarHidden(true)
//        }
//    }
//}
//
//struct HomePageView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomePageView()
//    }
//}



import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var isGetStartedClicked = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("MasterKick")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                Text("Master Every Kick, Reach Every Goal")
                    .font(.headline)
                    .foregroundColor(.blue)

                Spacer()

                if !isGetStartedClicked {
                    
                    Button(action: {
                        isGetStartedClicked = true
                    }) {
                        Text("Get Started")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 30)
                } else {
                    if userManager.isLoggedIn {
                        
                        VStack(spacing: 15) {
                            Text("Welcome Back, \(userManager.currentUser?.username ?? "User")")
                                .font(.title2)
                                .fontWeight(.bold)

                            NavigationLink(destination: DashboardView()) {
                                Text("Go to Dashboard")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 30)

                            Button(action: {
                                handleLogOut()
                            }) {
                                Text("Log Out")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 30)
                        }
                    } else {
                        
                        VStack(spacing: 15) {
                            NavigationLink(destination: SignInView()) {
                                Text("Sign In")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 30)

                            NavigationLink(destination: SignUpView()) {
                                Text("Sign Up")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            .padding(.horizontal, 30)
                        }
                    }
                }

                Spacer()
            }
            .padding()
            .navigationBarHidden(true)
        }
    }

    private func handleLogOut() {
        userManager.logout()
        isGetStartedClicked = false
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(UserManager()) 
    }
}
