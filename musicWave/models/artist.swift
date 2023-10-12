//
//  artist.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 11/10/2023.
//

import Foundation

struct Artist {
        let id: Int
        let name: String
        //let link: String
        //let picture: String
        //let pictureSmall: String
        let pictureMedium: String
        //let pictureBig: String
        //let pictureXL: String
        //let type: String
    
    }

extension Artist {
    init?(json: [String: AnyObject]){
        guard let id = json["id"] as? Int,
              let name = json["name"] as? String,
              let pictureMedium = json["picture_medium"] as? String
        else {
            return nil
        }
        self.id = id
        self.name = name
        self.pictureMedium = pictureMedium
    }
}



