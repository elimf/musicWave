import AVFoundation

class AudioPlayerManager {
    static let shared = AudioPlayerManager()

    var player: AVPlayer?

    private init() {
        player = AVPlayer()
    }

    func playAudio(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player?.replaceCurrentItem(with: playerItem)
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
