//
//  Track.swift
//  MusicApp-ios
//
//  Created by Jacob Weate on 4/13/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import Foundation

struct RawTrack: Decodable {
    var id: String
    var title: String
    var artists = [String]()
    var album: String
    var artwork: String
    var duration_ms: Int
}

struct Track {
    
    let id: String
    let title: String
    var artists = [String]()
    let duration: Int
    let album: String
    let artwork: UIImage
    
    init(_ rawTrack: RawTrack ) {
        id = rawTrack.id
        title = rawTrack.title
        artists = rawTrack.artists
        album = rawTrack.album
        duration = rawTrack.duration_ms
        let url = URL(string: rawTrack.artwork)
        if let data = try? Data(contentsOf: url!) {
            artwork = UIImage(data: data)!
        }
        else {
            // Change to default image
            artwork = UIImage(named: "SS3")!
        }
    }
}

