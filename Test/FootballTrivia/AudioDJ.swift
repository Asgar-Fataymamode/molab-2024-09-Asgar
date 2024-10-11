import AVFoundation

class AudioDJ: ObservableObject {
    @Published var player: AVAudioPlayer? = nil
    let uefaChampionsLeagueSong = "UEFA.mp3" // Replace with the actual file name if necessary

    init() {
        print("AudioDJ init")
    }

    func play() {
        player = loadAudio(uefaChampionsLeagueSong)
        player?.numberOfLoops = -1 // Loop indefinitely
        player?.play()
    }

    func stop() {
        player?.stop()
    }

    func loadAudio(_ fileName: String) -> AVAudioPlayer? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: nil) else {
            print("Audio file not found: \(fileName)")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        do {
            return try AVAudioPlayer(contentsOf: url)
        } catch {
            print("Error loading audio: \(error)")
            return nil
        }
    }
}
