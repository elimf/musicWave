import UIKit

class ArtistCollectionViewCell : UICollectionViewCell {
    var navigationController: UINavigationController?
    
    @IBOutlet weak var items: UIView!
    @IBOutlet weak var artistImage: UIImageView!
    @IBOutlet weak var labelArtist: UILabel!
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
    
    public func configure(with model: Artist) {
        
        if let imageUrl = URL(string: model.pictureMedium), let imageData = try? Data(contentsOf: imageUrl) {
            if let image = UIImage(data: imageData) {
                artistImage.image = image
                artistImage.contentMode = .scaleAspectFill
                artistImage.layer.cornerRadius = (artistImage.frame.size.height) / 14
                artistImage.clipsToBounds = true
            }
        }
        labelArtist.text = model.name
    }
}
