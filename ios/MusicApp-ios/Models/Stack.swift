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
            "artists": [
                "Young Thug"
            ],
            "album": "Slime season 3",
            "duration_ms": 197746,
            "id": "0tISnxqgVmxqhVghsTi2Rr",
            "artworkURL": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
        },
        {
            "title": "Memo",
            "artists": [
                "Young Thug"
            ],
            "album": "Slime season 3",
            "duration_ms": 195413,
            "id": "7tk5tOCj84jine8kKJkPYs",
            "artworkURL": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
        },
        {
            "title": "Drippin'",
            "artists": [
                "Young Thug"
            ],
            "album": "Slime season 3",
            "duration_ms": 186453,
            "id": "0f85bMoarvHbdIcfhDjSjN",
            "artworkURL": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
        },
        {
            "title": "Slime Shit (feat. Yak Gotti, Duke & Peewee Roscoe)",
            "artists": [
                "Young Thug",
                "Yak Gotti",
                "Duke",
                "PeeWee Roscoe"
            ],
            "album": "Slime season 3",
            "duration_ms": 278040,
            "id": "7iynYKl5NWdjM1FXTzs6hw",
            "artworkURL": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
        },
        {
            "title": "Digits",
            "artists": [
                "Young Thug"
            ],
            "album": "Slime season 3",
            "duration_ms": 176386,
            "id": "4cg1yakyRSIOjxKM2I7J1q",
            "artworkURL": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
        },
        {
            "title": "Worth It",
            "artists": [
                "Young Thug"
            ],
            "album": "Slime season 3",
            "duration_ms": 186026,
            "id": "5QCr1xFufKJOTkpcR9ih24",
            "artworkURL": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
        },
        {
            "title": "Tattoos",
            "artists": [
                "Young Thug"
            ],
            "album": "Slime season 3",
            "duration_ms": 241813,
            "id": "1vbUiccx25u2ncTe4RujS2",
            "artworkURL": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
        },
        {
            "title": "Problem",
            "artists": [
                "Young Thug"
            ],
            "album": "Slime season 3",
            "duration_ms": 241453,
            "id": "1o5jdqnWybW9Mau4GDWPMa",
            "artworkURL": "https://i.scdn.co/image/aa0ad7304c2d98477434b270bed98f609f37a692",
        }
    ]
}
"""

class Stack {
    
    public var trackList = LinkedList<Track>()
    public var newConnList = [String]()
    static let instance = Stack()
    var accessToken: String?
    
    init() {
        var urlComp = URLComponents(string: "http://ec2-18-205-232-42.compute-1.amazonaws.com/recs")
        accessToken = RootController.firstTimeSession?.accessToken
        urlComp?.queryItems = [
            URLQueryItem(name: "access_token", value: accessToken),
            URLQueryItem(name: "user_id", value: "user5")
        ]
        let url = urlComp?.url
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        var jsonData: Data?
        
        // Need semaphore because dataTask is asynchronous
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { data,response,err in
            let resp = response as! HTTPURLResponse
            if resp.statusCode != 200 {
                // Use sample data if response status code is not 200
                jsonData = sampleData.data(using: .utf8)
            } else {
                jsonData = data
            }
            semaphore.signal()
        }.resume()
        semaphore.wait()
        
        let decoder = JSONDecoder()
        let rec = try! decoder.decode(Rec.self, from: jsonData!)

        os_log("Loaded tracks")

        for rawTrack in rec.tracks {
            let track = Track(rawTrack)
            trackList.append(value: track)
        }
        
        for user in rec.new_connections {
            newConnList.append(user)
        }
        
    }
    
    public func size() -> Int {
        return trackList.size
    }
    
    public func push(track: Track) {
        trackList.append(value: track)
    }
    
    public func pop() -> Track? {
        return trackList.removeAt(0)
    }
    
    public func removeAt(atIndex index: Int) -> Track? {
        return trackList.removeAt(index)
    }
    
    public func getAt(atIndex index: Int) -> Track? {
        return trackList.nodeAt(atIndex: index)?.value
    }
    
    public func toArray() -> [Track] {
        var array = [Track]()
        for i in 0..<size() {
            array.append(getAt(atIndex: i)!)
        }
        return array
    }
    
}

