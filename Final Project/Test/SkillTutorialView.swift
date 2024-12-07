//
//  SkillTutorialView.swift
//  Test
//
//  Created by Muhammad Ali Asgar Fataymamode on 05/12/2024.
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
                
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)

                
                if let videoID = extractYouTubeID(from: youtubeURL) {
                    YouTubePlayerView(videoID: videoID)
                        .frame(height: 200)
                        .cornerRadius(10)
                } else {
                    Text("Video unavailable")
                        .font(.subheadline)
                        .foregroundColor(.red)
                }

                
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
        .navigationBarTitleDisplayMode(.inline)
    }

    func extractYouTubeID(from url: String) -> String? {
        URLComponents(string: url)?
            .queryItems?
            .first(where: { $0.name == "v" })?
            .value
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

struct SkillTutorialView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SkillTutorialView(
                title: "Basic Shot-Stopping Techniques",
                youtubeURL: "https://www.youtube.com/watch?v=qSdvcaqUMXc&pp=ygUnYmFzaWMgc2hvdC1zdG9wcGluZyB0ZWNobmlxdWVzIGZvb3RiYWxs",
                explanation: """
                Master the art of basic shot-stopping as a goalkeeper. Learn how to:
                1. Position yourself to cover the goal effectively.
                2. React quickly to shots aimed at different corners.
                3. Use proper hand placement and footwork to block or catch the ball.
                """
            )
        }
    }
}
