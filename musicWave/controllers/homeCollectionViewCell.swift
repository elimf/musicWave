//
//  homeCollectionViewCell.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 11/10/2023.
//

import UIKit

class homeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
        
        public func configure(with model: Track) {
            
            if let imageUrl = URL(string: model.album.coverMedium), let imageData = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: imageData) {
                    coverImageView.image = image
                    coverImageView.contentMode = .scaleAspectFill
                    coverImageView.layer.cornerRadius = (coverImageView.frame.size.height) / 14
                    coverImageView.clipsToBounds = true
                }
            }
            trackLabel.text = model.title
            artistLabel.text = model.artist.name
        }
}
