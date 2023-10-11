//
//  track.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 11/10/2023.
//

import Foundation

struct Track {
    let id: String
    let title: String
    let title_short: String
    let title_version: String
    let link: String
    let duration: String
    let rank: String
    let explicit_lyrics: Bool
    let explicit_content_lyrics: Int
    let explicit_content_cover: Int
    let preview: String
    let md5_image: String
    let artist: Artist
    let album: Album
    let type: String
}
