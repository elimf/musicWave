import AVFoundation

class AudioPlayerManager {
    static let shared = AudioPlayerManager()

    var player: AVPlayer?

    private init() {
        player = AVPlayer()
    }

    func playAudio(url: URL) {
        do {
                    player = try AVPlayer(url: url)

                  
                } catch let error {
                    print(error)
                }
                player?.play()
        
    }

    func pause() {
        player?.pause()
    }

    func stop() {
        player?.pause()
        player?.replaceCurrentItem(with: nil)
    }
}
