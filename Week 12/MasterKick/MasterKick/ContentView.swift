//
//  ContentView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 14/11/2024.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        HomePageView()
//    }
//}
//
//#Preview {
//    ContentView()
//}



import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        NavigationView {
            if userManager.isLoggedIn {
                DashboardView()
            } else {
                HomePageView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserManager())
    }
}

