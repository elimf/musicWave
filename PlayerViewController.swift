//
//  PlayerViewController.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 11/10/2023.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    var track: Track?
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedTrack = track {
            
            let URLStr = selectedTrack.album.coverMedium
            if let url = URL(string: URLStr), let data = try? Data(contentsOf: url) {
                trackImageView.image = UIImage(data: data)
            }
            
            trackLabel.text = selectedTrack.title
            artistLabel.text = selectedTrack.artist.name
            
            let audioUrl = URL(fileURLWithPath: selectedTrack.preview)
            AudioPlayerManager.shared.playAudio(url: audioUrl)
        }
    }
    
    @IBAction func playerButton(_ sender: Any) {
        if let player = AudioPlayerManager.shared.player {
                if player.timeControlStatus == .playing {
                    AudioPlayerManager.shared.pause()
                    print("music pause")
                } else {
                    player.play()
                    print("music playing")
                }
            }
    }
}

