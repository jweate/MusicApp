//
//  Recs.swift
//  MusicApp-ios
//
//  Created by CS3714 on 5/3/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import Foundation

struct Rec: Decodable {
    var tracks: [RawTrack]
    var new_connections: [String]
}
