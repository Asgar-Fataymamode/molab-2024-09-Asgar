//
//  TitleScreen.swift
//  FootballDiary
//
//  Created by Muhammad Ali Asgar Fataymamode on 23/10/2024.
//


import SwiftUI

struct TitleScreen: View {
    @State private var showBook = false
    @State private var gradientOffset: CGFloat = 0.0

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.gray, .black, .gray]),
                startPoint: UnitPoint(x: gradientOffset, y: 0),
                endPoint: UnitPoint(x: 1 - gradientOffset, y: 1)
            )
            .ignoresSafeArea()
            .onAppear {
                withAnimation(Animation.linear(duration: 5.0).repeatForever(autoreverses: true)) {
                    gradientOffset = 1.0
                }
            }

            VStack {
                Text("Football Diary")
                    .font(.largeTitle)
                    .padding()
                    .foregroundColor(.white)

                Button(action: {
                                    withAnimation(.easeInOut(duration: 1.0)) {
                                        showBook = true
                                    }
                                }) {
                                    Text("Open Book")
                                    .font(.headline)
//                                  .padding()
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 16)
                                    .background(Color.white)
                                    .foregroundColor(.black)
                                    .cornerRadius(10)
                                }
//                              .padding()
                                .padding(.vertical, 10) 
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                                .padding()
            }
        }
        .fullScreenCover(isPresented: $showBook) {
            ContentView()
        }
    }
}

