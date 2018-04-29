//
//  Event.swift
//  MusicApp-ios
//
//  Created by CS3714 on 4/29/18.
//  Copyright © 2018 Tomy Doan. All rights reserved.
//

import Foundation

struct RawEvent: Decodable {
    var idEvent: String
    var idUser: String
    var eventType: String
    var title: String
    var artist: String
}


struct Event {
    
    var idEvent: String
    var idUser: String
    var eventType: String
    var title: String
    var artist: String
    
    init(_ rawEvent: RawEvent ) {
        idEvent = rawEvent.idEvent
        idUser = rawEvent.idUser
        eventType = rawEvent.eventType
        title = rawEvent.title
        artist = rawEvent.artist
    }
}

