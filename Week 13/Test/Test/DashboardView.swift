//
//  DashboardView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
//


import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        TabView {
            ProgressTrackerView()
                .tabItem {
                    Label("Progress Tracker", systemImage: "chart.bar.fill")
                }

            GoalsChallengesView()
                .tabItem {
                    Label("Goals", systemImage: "flag.fill")
                }

            CommunityView()
                .tabItem {
                    Label("Community", systemImage: "person.3.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .onAppear {
            print("Dashboard loaded for user: \(userManager.currentUser?.username ?? "Unknown")")
        }
        .navigationBarHidden(true)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(UserManager())
    }
}
