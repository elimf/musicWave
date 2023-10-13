import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    var track: Track?
    var trackArray : Album?
    var trackList: TrackList?
    var playerTimeObserver: Any?
    var isSeeking = false
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedTrack = track {
            let URLStr = selectedTrack.album.coverBig
            if let url = URL(string: URLStr), let data = try? Data(contentsOf: url) {
                trackImageView.image = UIImage(data: data)
            }
            
            trackLabel.text = selectedTrack.title
            artistLabel.text = selectedTrack.artist.name
            
            let audioUrl = URL(string: selectedTrack.preview)!
            AudioPlayerManager.shared.playAudio(url: audioUrl)
            trackSlider.maximumValue = 30.0
            playerTimeObserver = AudioPlayerManager.shared.player?.addPeriodicTimeObserver(
                forInterval: CMTime(seconds: 0.1, preferredTimescale: 600),
                queue: .main
            ) { [weak self] time in
                if !self!.isSeeking {
                    let currentTime = CMTimeGetSeconds(time)
                    self?.trackSlider.value = Float(currentTime)
                }
            }
        }
        if let selectedTrack = trackList {
            
            if let url = URL(string: "https://api.deezer.com/album/\(String(describing: trackList?.id))") {
                let session = URLSession.shared
                
                let task = session.dataTask(with: url) {
                    (data, response, error) in
                    if let error = error {
                        print(error)
                        
                    } else if let data = data {
                        print(data)
                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                        self.mapAlbum(json : json as AnyObject)
                    }
                    
                    
                    
                }
               
            }
            if let URLStr = trackList?.trackImage {
                if let url = URL(string: URLStr), let data = try? Data(contentsOf: url) {
                    trackImageView.image = UIImage(data: data)
                }
            }

           
            trackLabel.text = selectedTrack.title
            artistLabel.text = selectedTrack.artist.name
            
            let audioUrl = URL(string: selectedTrack.preview)!
            AudioPlayerManager.shared.playAudio(url: audioUrl)
            trackSlider.maximumValue = 30.0
            playerTimeObserver = AudioPlayerManager.shared.player?.addPeriodicTimeObserver(
                forInterval: CMTime(seconds: 0.1, preferredTimescale: 600),
                queue: .main
            ) { [weak self] time in
                if !self!.isSeeking {
                    let currentTime = CMTimeGetSeconds(time)
                    self?.trackSlider.value = Float(currentTime)
                }
            }
        }
    }
    func mapAlbum(json: AnyObject) {
       if  let data = json["data"] as? [[String : AnyObject]] {
           for item in data {
               if let album = Album(json: item){
                   self.trackArray = album

                   print(item)
               }
           }
       } else {
           print("Invalid JSON format: 'data' is not an array or JSON is not in the expected format.")
       }
       
   }
    deinit {
        if let playerTimeObserver = playerTimeObserver {
            AudioPlayerManager.shared.player?.removeTimeObserver(playerTimeObserver)
        }
    }
    @IBAction func playerButton(_ sender: Any) {
        if let player = AudioPlayerManager.shared.player {
            if player.timeControlStatus == .playing {
                AudioPlayerManager.shared.pause()
                print("Music paused")
            } else {
                player.play()
                print("Music playing")
            }
        }
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        if !isSeeking {
            let currentTime = Double(sender.value)
            let time = CMTime(seconds: currentTime, preferredTimescale: 1)
            AudioPlayerManager.shared.player?.seek(to: time)
        }
    }
    
    @IBAction func sliderTouchDown(_ sender: UISlider) {
        isSeeking = true
    }

    @IBAction func sliderTouchUpInside(_ sender: UISlider) {
        isSeeking = false
    }
    
    @IBAction func sliderTouchUpOutside(_ sender: UISlider) {
        isSeeking = false
    }
}
