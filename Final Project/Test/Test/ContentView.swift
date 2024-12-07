//
//  ContentView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 04/12/2024.
//




import SwiftUI

struct ContentView: View {
    var body: some View {
        HomePageView()
            .environmentObject(UserManager())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserManager()) 
    }
}
