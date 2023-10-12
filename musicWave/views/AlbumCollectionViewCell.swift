//
//  AlbumCollectionViewCell.swift
//  musicWave
//
//  Created by Eddy on 12/10/2023.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImage: UIImageView!
    
    @IBOutlet weak var labelAlbum: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
        }
    
    public func configure(with model: Album) {
        
        if let imageUrl = URL(string: model.coverMedium), let imageData = try? Data(contentsOf: imageUrl) {
            if let image = UIImage(data: imageData) {
                albumImage.image = image
                albumImage.contentMode = .scaleAspectFill
                albumImage.layer.cornerRadius = (albumImage.frame.size.height) / 14
                albumImage.clipsToBounds = true
            }
        }
        labelAlbum.text = model.title
    
        
    }
}
