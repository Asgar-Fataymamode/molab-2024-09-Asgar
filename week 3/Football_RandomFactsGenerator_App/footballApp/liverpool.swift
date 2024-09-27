import SwiftUI

struct LiverpoolView: View {
    @State private var shuffledFactsAndImages: [(fact: String, imageName: String)] = []
    @State private var currentIndex: Int = 0
    @State private var randomFact: String = "Click the button to generate a random fact!"
    @State private var randomImageName: String = "liverpool1"

    var body: some View {
        VStack {
            Image(randomImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
                .cornerRadius(20)

            Text(randomFact)
                .font(.headline)
                .padding()

            Button(action: generateRandomFact) {
                Text("Generate Random Fact")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear(perform: shuffleFactsAndImages)
        .navigationTitle("Liverpool")
    }

    func generateRandomFact() {
        if currentIndex >= shuffledFactsAndImages.count {
            shuffleFactsAndImages()
        }
        let currentFactAndImage = shuffledFactsAndImages[currentIndex]
        randomFact = currentFactAndImage.fact
        randomImageName = currentFactAndImage.imageName
        currentIndex += 1
    }

    func shuffleFactsAndImages() {
        let club = footballClubs.first(where: { $0.name == "Liverpool" })!
        shuffledFactsAndImages = club.factsAndImages.shuffled()
        currentIndex = 0
    }
}
