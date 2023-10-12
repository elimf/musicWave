//
//  track.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 11/10/2023.
//

import Foundation

struct Track {
    //let id: String
    let title: String
    //let title_short: String
    //let title_version: String
    let link: String
    let duration: Int
    //let rank: String
    //let explicit_lyrics: Bool
    //let explicit_content_lyrics: Int
    //let explicit_content_cover: Int
    let preview: String
    //let md5_image: String
    let artist: Artist
    let album: Album
    //let type: String
}

extension Track {
    init?(json: [String: AnyObject]) {
        
        guard let title = json["title"] as? String,
              let url = json["link"] as? String,
              let duration = json["duration"] as? Int,
              let album = json["album"] as? [String:AnyObject],
              let artist = json["artist"] as? [String: AnyObject],
              let preview = json["preview"] as? String
        else {
            print("nullllllll")
            return nil
        }
        
        self.title = title
        self.link = url
        self.duration = duration
        self.album = Album(json: album)!
        self.artist = Artist(json: artist)!
        self.preview = preview
    }
    
}
