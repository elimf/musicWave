//
//  artist.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 11/10/2023.
//

import Foundation

struct TrackListArtist {
        let id: Int
        let name: String
    }

extension TrackListArtist {
    init?(json: [String: AnyObject]){
        guard let id = json["id"] as? Int,
              let name = json["name"] as? String
        else {
            return nil
        }
        self.id = id
        self.name = name
    }
}



