import SwiftUI

struct ChelseaView: View {
    // Array to hold the shuffled list of facts and images
    @State private var shuffledFactsAndImages: [(fact: String, imageName: String)] = []
    // Index to track the current fact and image being displayed
    @State private var currentIndex: Int = 0
    // Fact and image to display
    @State private var randomFact: String = "Click the button to generate a random fact!"
    @State private var randomImageName: String = "chelsea1"  // Default image for Chelsea

    var body: some View {
        VStack {
            // Use local image from Assets.xcassets
            Image(randomImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 350)
                .cornerRadius(20)

            // Display the fact
            Text(randomFact)
                .font(.headline)
                .padding()

            // Button to generate random fact
            Button(action: generateRandomFact) {
                Text("Generate Random Fact")
                    .padding()
                    .background(Color.black)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear(perform: shuffleFactsAndImages)
        .navigationTitle("Chelsea")
    }

    // Function to generate the next fact and image in the sequence
    func generateRandomFact() {
        // Check if we've reached the end of the shuffled array
        if currentIndex >= shuffledFactsAndImages.count {
            // Reshuffle the array and restart from the beginning
            shuffleFactsAndImages()
        }

        // Get the current fact and image
        let currentFactAndImage = shuffledFactsAndImages[currentIndex]
        randomFact = currentFactAndImage.fact
        randomImageName = currentFactAndImage.imageName
        
        // Move to the next fact/image for the next click
        currentIndex += 1
    }

    // Shuffle the facts and images and reset the index
    func shuffleFactsAndImages() {
        let club = footballClubs.first(where: { $0.name == "Chelsea" })!
        shuffledFactsAndImages = club.factsAndImages.shuffled()  // Shuffle the facts and images
        currentIndex = 0  // Reset the index to start from the beginning
    }
}

struct ChelseaView_Previews: PreviewProvider {
    static var previews: some View {
        ChelseaView()
    }
}
