import UIKit

class TapGestureRecognizerWithArtist: UITapGestureRecognizer {
    var artist: Artist
    
    init(target: Any?, action: Selector?, artist: Artist) {
        self.artist = artist
        super.init(target: target, action: action)
    }
}
