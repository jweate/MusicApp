//
//  Stack.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/15/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import os.log

let sampleData = """
{
    "tracks": [
        {
            "title": "With Them",
            "artist": "Young Thug",
            "album": "Slime season 3",
            "duration_ms": 197746,
            "id": "0tISnxqgVmxqhVghsTi2Rr",
            "image": {
                "height": 300,
                "url": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
                "width": 300
            },
        },
        {
            "title": "Memo",
            "artist": "Young Thug",
            "album": "Slime season 3",
            "duration_ms": 195413,
            "id": "7tk5tOCj84jine8kKJkPYs",
            "image": {
                "height": 300,
                "url": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
                "width": 300
            },
        },
        {
            "title": "Drippin'",
            "artist": "Young Thug",
            "album": "Slime season 3",
            "duration_ms": 186453,
            "id": "0f85bMoarvHbdIcfhDjSjN",
            "image": {
                "height": 300,
                "url": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
                "width": 300
            },
        },
        {
            "title": "Slime Shit (feat. Yak Gotti, Duke & Peewee Roscoe)",
            "artist": "Young Thug",
            "album": "Slime season 3",
            "duration_ms": 278040,
            "id": "7iynYKl5NWdjM1FXTzs6hw",
            "image": {
                "height": 300,
                "url": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
                "width": 300
            },
        },
        {
            "title": "Digits",
            "artist": "Young Thug",
            "album": "Slime season 3",
            "duration_ms": 176386,
            "id": "4cg1yakyRSIOjxKM2I7J1q",
            "image": {
                "height": 300,
                "url": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
                "width": 300
            },
        },
        {
            "title": "Worth It",
            "artist": "Young Thug",
            "album": "Slime season 3",
            "duration_ms": 186026,
            "id": "5QCr1xFufKJOTkpcR9ih24",
            "image": {
                "height": 300,
                "url": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
                "width": 300
            },
        },
        {
            "title": "Tattoos",
            "artist": "Young Thug",
            "album": "Slime season 3",
            "duration_ms": 241813,
            "id": "1vbUiccx25u2ncTe4RujS2",
            "image": {
                "height": 300,
                "url": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
                "width": 300
            },
        },
        {
            "title": "Problem",
            "artist": "Young Thug",
            "album": "Slime season 3",
            "duration_ms": 241453,
            "id": "1o5jdqnWybW9Mau4GDWPMa",
            "image": {
                "height": 300,
                "url": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
                "width": 300
            },
        }
    ],
}
"""

struct RawTrackList: Decodable {
    var tracks: [RawTrack]
}

class Stack {
    
    public var list = LinkedList<Track>()
    static let instance = Stack()
    
    init() {
        let jsonData = sampleData.data(using: .utf8)
        let decoder = JSONDecoder()
        let rawTrackList = try! decoder.decode(RawTrackList.self, from: jsonData!)
        
        os_log("Loaded tracks")
        
        let albumArtwork = UIImage(named: "SS3")
        
        for rawTrack in rawTrackList.tracks {
            print("Appending Track ----")
            print("  title: \(rawTrack.title)")
            print("  artist: \(rawTrack.artist)")
            print("  album: \(rawTrack.album)")
            let track = Track(rawTrack, image: albumArtwork!)
            list.append(value: track)
            Queue.instance.append(track: track)
        }
        
    }
    
    public func size() -> Int {
        return list.size
    }
    
    public func push(track: Track) {
        list.append(value: track)
    }
    
    public func pop() -> Track? {
        return list.removeAt(0)
    }
    
    public func removeAt(atIndex index: Int) -> Track? {
        return list.removeAt(index)
    }
    
    public func getAt(atIndex index: Int) -> Track? {
        return list.nodeAt(atIndex: index)?.value
    }
    
    
    public func toArray() -> [Track] {
        var array = [Track]()
        for i in 0..<size() {
            array.append(getAt(atIndex: i)!)
        }
        return array
    }
    
}

