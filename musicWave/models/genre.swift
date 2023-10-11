//
//  genre.swift
//  musicWave
//
//  Created by Massimiliano HUBERT-ABBATE on 11/10/2023.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let name: String
    let picture: String
    let type: String
}
