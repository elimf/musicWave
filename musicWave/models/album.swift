//
//  album.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 11/10/2023.
//

import Foundation

struct Album {
        let id: Int
        let title: String
        //let cover: String
        let coverMedium: String
        let coverBig: String
        /*let coverXL: String
        let md5Image: String
        let tracklist: String
        let type: String
        let genre_id: Int
        let genres: [Genre]
        let label: String
        let nb_tracks: Int
        let duration: Int
        let release_date: String
        let record_type: String
        let artist: Artist
        let tracks: [Track]*/
    
    
    }

extension Album {
    init?(json: [String: AnyObject]) {
        guard let title = json["title"] as? String,
              let coverMedium = json["cover_medium"] as? String,
                let coverBig = json["cover_big"] as? String,
                let id = json["id"] as? Int
        else {
            return nil
        }
        self.title = title
        self.coverMedium = coverMedium
        self.coverBig = coverBig
        self.id = id
    }
}
