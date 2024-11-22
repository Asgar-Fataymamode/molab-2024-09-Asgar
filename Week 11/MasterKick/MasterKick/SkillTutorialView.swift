//
//  SkillTutorialView.swift
//  MasterKick
//
//  Created by Muhammad Ali Asgar Fataymamode on 21/11/2024.
//
import SwiftUI
import WebKit

struct SkillTutorialView: View {
    let title: String
    let youtubeURL: String
    let explanation: String
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Title
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                // YouTube Video
                YouTubePlayerView(videoID: extractYouTubeID(from: youtubeURL))
                    .frame(height: 200)
                    .cornerRadius(10)
                
                // Explanation
                Text("Explanation")
                    .font(.headline)
                    .padding(.top, 10)
                
                Text(explanation)
                    .font(.body)
                    .padding(.top, 5)
            }
            .padding()
        }
        .navigationTitle("Skill Tutorial")
    }
    
    func extractYouTubeID(from url: String) -> String {
        return URLComponents(string: url)?
            .queryItems?
            .first(where: { $0.name == "v" })?
            .value ?? ""
    }
}

struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: "https://www.youtube.com/embed/\(videoID)") else { return }
        uiView.scrollView.isScrollEnabled = false
        uiView.load(URLRequest(url: url))
    }
}
