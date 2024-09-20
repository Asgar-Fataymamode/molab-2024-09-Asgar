// Asgar Fataymamode - Mobile App Development Assignment 2

import Foundation

// Function to load and display the content of the txt file
func displayASCIIArt(fromFile fileName: String, withDescription description: String) {
    if let filePath = Bundle.main.path(forResource: fileName, ofType: "txt") {
        if let content = try? String(contentsOfFile: filePath) {
            print(description)
            print(content)
            print("\n                   -------------------------\n") // Separator between images
        } else {
            print("Could not load content of \(fileName).txt")
        }
    } else {
        print("File \(fileName).txt not found in resources.")
    }
}

// Descriptions and file names to be printed
let asciiImages = [
    ("Welcome to the stadium in which the game will be played", "stadium"),
    ("Here is the ball that will be used in the game", "ball"),
    ("All the players on the field", "all_players"),
    ("The match has officially started!", "matchstart"),
    ("Player A gets the ball", "playerstands"),
    ("Player A shoots the ball", "playershoots"),
    ("The goalie is ready to defend the goal", "goalie"),
    ("GOAL! The ball goes in!", "goal")
]

print("Welcome to today's football game!")
print()
print()

// Loop to display each image in sequence
for (description, fileName) in asciiImages {
    displayASCIIArt(fromFile: fileName, withDescription: description)
}
