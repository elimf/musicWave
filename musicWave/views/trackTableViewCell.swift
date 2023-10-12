//
//  trackTableViewCell.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 12/10/2023.
//

import UIKit

class trackTableViewCell: UITableViewCell {

    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    public func configure(with model: TrackList) {
        
        artistLabel.text = model.title
        
        
    }
}
