//
//  Track.swift
//  MusicApp-ios
//
//  Created by Jacob Weate on 4/13/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import Foundation

struct RawTrack: Decodable {
    struct Artist: Decodable {
        var name: String
    }
    
    var id: String
    var name: String
    var artists: [Artist]
    var duration_ms: Int
}

/*
struct Track: Decodable {
    
    let id: String
    let title: String
    let artist: String
    let duration: Int
    
    let album: String?
    let artwork: UIImage?
    
    enum CodingKeys : String, CodingKey {
        case title = "name"
        case artist
    }
    
    init(from decoder: Decoder) throws {
        let rawTrack = try RawTrack(from: decoder)
        
        id = rawTrack.id
        title = rawTrack.name
        artist = rawTrack.artists[0].name
        duration = rawTrack.duration_ms
    }
}
*/
