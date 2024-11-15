//
//  DashboardView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 14/11/2024.
//

import SwiftUI

struct DashboardView: View {
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
        .navigationBarTitle("Dashboard", displayMode: .inline)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
