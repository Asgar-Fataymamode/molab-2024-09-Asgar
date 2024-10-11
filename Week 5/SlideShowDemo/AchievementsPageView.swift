import SwiftUI

struct AchievementsPageView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("clubPerfectScore") var clubPerfectScore = false
    @AppStorage("internationalPerfectScore") var internationalPerfectScore = false
    @AppStorage("solvedWithin10Seconds") var solvedWithin10Seconds = false
    @AppStorage("solvedWithin5Seconds") var solvedWithin5Seconds = false

    var body: some View {
        VStack {
            Text("Achievements")
                .font(.largeTitle)
                .padding()

            // Club Perfect Score Achievement
            HStack {
                Text("🏆 Perfect Club Score")
                Spacer()
                Image(systemName: clubPerfectScore ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(clubPerfectScore ? .green : .red)
            }
            .padding()

            // International Perfect Score Achievement
            HStack {
                Text("🏆 Perfect International Score")
                Spacer()
                Image(systemName: internationalPerfectScore ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(internationalPerfectScore ? .green : .red)
            }
            .padding()

            // Solved Under 10 Seconds Achievement
            HStack {
                Text("⏱️ Solved All Questions Under 10 Seconds")
                Spacer()
                Image(systemName: solvedWithin10Seconds ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(solvedWithin10Seconds ? .green : .red)
            }
            .padding()

            // Solved Under 5 Seconds Achievement
            HStack {
                Text("⚡ Solved All Questions Under 5 Seconds")
                Spacer()
                Image(systemName: solvedWithin5Seconds ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(solvedWithin5Seconds ? .green : .red)
            }
            .padding()

            Spacer()

//            // Close button
//            Button(action: {
//                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
//            }) {
//                Text("Close")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//            .padding()
            Button(action: {
                            // Dismiss the achievements page and go back to homepage
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Close")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .padding()
                        }
        }
        .padding()
    }
}
