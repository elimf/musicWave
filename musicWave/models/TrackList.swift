//
//  TrackList.swift
//  musicWave
//
//  Created by Eddy on 12/10/2023.
//

import Foundation


struct TrackList{
    
    let title: String
    
    let link: String
    let duration: Int
    let trackImage : String
    let preview: String
    let artist: TrackListArtist
   let id: Int
}

extension TrackList : Equatable {
    static func == (lhs: TrackList, rhs: TrackList) -> Bool {
            return lhs.id == rhs.id 
        }
    init?(json: [String: AnyObject], trackImage : String) {
        
        guard let title = json["title"] as? String,
              let url = json["link"] as? String,
              let duration = json["duration"] as? Int,
              let preview = json["preview"] as? String,
              let artist = json["artist"] as? [String: AnyObject],
              let id = json["id"] as? Int
            
                       
        else {
            return nil
        }
        
        self.title = title
        self.link = url
        self.duration = duration
        self.preview = preview
        self.artist = TrackListArtist(json: artist)!
        self.id = id
        self.trackImage = trackImage
    }
    
}
