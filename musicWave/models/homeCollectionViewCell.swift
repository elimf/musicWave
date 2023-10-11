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
            coverImageView.image = model.image
            trackLabel.text = model.name
            artistLabel.text = model.
        }
}
