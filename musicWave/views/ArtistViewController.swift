//
//  ArtistViewController.swift
//  musicWave
//
//  Created by Eddy on 12/10/2023.
//

import UIKit

class ArtistViewController: UIViewController {
    var albumArray : [Album] = []
    
    var artist : Artist?
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var artistImage: UIImageView!
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Artiste"
        self.artistLabel.text = artist?.name
    }
   
    
    
      
      
   

}
