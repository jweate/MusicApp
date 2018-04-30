//
//  Event.swift
//  MusicApp-ios
//
//  Created by CS3714 on 4/29/18.
//  Copyright © 2018 Tomy Doan. All rights reserved.
//

import Foundation

struct RawEvent: Decodable {
    var idEvent: Int
    var idUser: String
    var eventType: String
    var trackName: String
    var artistName: String
    var songID: String
}


struct Event {
    
    var idEvent: Int
    var idUser: String
    var eventType: String
    var trackName: String
    var artistName: String
    var songID: String
    
    init(_ rawEvent: RawEvent ) {
        idEvent = rawEvent.idEvent
        idUser = rawEvent.idUser
        eventType = rawEvent.eventType
        trackName = rawEvent.trackName
        artistName = rawEvent.artistName
        songID = rawEvent.songID
    }
}

