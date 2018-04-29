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

struct RawTrackList: Decodable {
    var tracks: [RawTrack]
}

class Stack {
    
    public var list = LinkedList<Track>()
    static let instance = Stack()
    
    init() {
        var urlComp = URLComponents(string: "http://ec2-18-205-232-42.compute-1.amazonaws.com/recs")
        urlComp?.queryItems = [
            // TODO
            // Need to get access token after login
            // Just swap value of access_token with actual token value
            // Below var doesn't work because it's empty
            // var myaccesstoken = RootController.firstTimeSession?.accessToken
            URLQueryItem(name: "access_token", value: "paste_token_here"),
            URLQueryItem(name: "user_id", value: "0")
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
        let rawTrackList = try! decoder.decode(RawTrackList.self, from: jsonData!)

        os_log("Loaded tracks")
        
        for rawTrack in rawTrackList.tracks {
            print("Appending Track ----")
            print("  title: \(rawTrack.title)")
            print("artists: ", terminator: "")
    
            for (index, artist) in rawTrack.artists.enumerated() {
                if index == 0 {
                    print("\(artist)")
                } else {
                    print("         \(artist)")
                }
            }
            print("  album: \(rawTrack.album)")
            let track = Track(rawTrack)
            list.append(value: track)
            //Queue.instance.append(track: track)
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

