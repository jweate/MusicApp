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
    var title: String
    var artist: String
    var album: String
    var duration_ms: Int
}

/*
class Track {
    
    public var title: String?
    public var artist: String?
    public var id: String?
    
    init (_ Title: String, _ Id: String) {
        self.title = Title
        self.id = Id
    }
    
    
}
*/


struct Track {
    
    let id: String
    let title: String
    let artist: String
    let duration: Int
    let album: String
    let artwork: UIImage
    
    init(_ rawTrack: RawTrack, image: UIImage ) {
        id = rawTrack.id
        title = rawTrack.title
        artist = rawTrack.artist
        album = rawTrack.album
        duration = rawTrack.duration_ms
        artwork = image
    }
}
