import UIKit

class ArtistCollectionViewCell : UICollectionViewCell {
    var navigationController: UINavigationController?

    @IBOutlet weak var titleArtist: UILabel!
    
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
        titleArtist.text = String(model.id)
    
        
    }
    
    @objc func handleTap(_ sender: TapGestureRecognizerWithArtist){
        print(sender.artist.id)
           
        
        //let artistViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArtistVIewController") as! ArtistViewController
      
           
       
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ArtistVIewController") as? ArtistViewController{
        
        }
        //let navigationController = UINavigationController(rootViewController: vc)
       
    
        
        

    }
}
