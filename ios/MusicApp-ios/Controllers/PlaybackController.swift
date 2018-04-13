//
//  PlaybackView.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class PlaybackController: UIViewController, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {
    
    // Spotify properties
    var player: SPTAudioStreamingController?
    var auth = SPTAuth.defaultInstance()!
    var session: SPTSession!

    // Playback properties
    var playing = false
    var startTime = 0
    
    // MARK: Properties
    var playButton: UIButton?
    var skipForwardButton: UIButton?
    var skipBackwardButton: UIButton?
    var trackDurationSlider: UISlider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexString: "#333333")

        playButton = UIButton()
        skipForwardButton = UIButton()
        skipBackwardButton = UIButton()
        
        playButton!.backgroundColor = .red
        view.addSubview(playButton!)
        playButton!.translatesAutoresizingMaskIntoConstraints = false
        playButton!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        playButton!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        playButton!.heightAnchor.constraint(equalToConstant: 80).isActive = true
        playButton!.widthAnchor.constraint(equalToConstant: 80).isActive = true
        playButton!.addTarget(self, action: #selector(playTrack), for: .touchUpInside)
        
        skipForwardButton!.backgroundColor = .red
        view.addSubview(skipForwardButton!)
        skipForwardButton!.translatesAutoresizingMaskIntoConstraints = false
        skipForwardButton!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 100).isActive = true
        skipForwardButton!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        skipForwardButton!.heightAnchor.constraint(equalToConstant: 60).isActive = true
        skipForwardButton!.widthAnchor.constraint(equalToConstant: 60).isActive = true
        //skipForwardButton!.addTarget(self, action: #selector(skipTrack), for: .touchUpInside)
        
        skipBackwardButton!.backgroundColor = .red
        view.addSubview(skipBackwardButton!)
        skipBackwardButton!.translatesAutoresizingMaskIntoConstraints = false
        skipBackwardButton!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -100).isActive = true
        skipBackwardButton!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        skipBackwardButton!.heightAnchor.constraint(equalToConstant: 60).isActive = true
        skipBackwardButton!.widthAnchor.constraint(equalToConstant: 60).isActive = true
        skipBackwardButton!.addTarget(self, action: #selector(backTrack), for: .touchUpInside)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(createPlayer), name: Notification.Name("Playtime"), object: nil)
        
    }
    
    // creates the player when after the user authenticates himself
    @objc func createPlayer(){
        self.session = RootController.firstTimeSession!
        initializePlayer(authSession: session)
    }
    
    /*
     * Initializes the Spotify Player
     */
    func initializePlayer(authSession:SPTSession){
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player!.playbackDelegate = self
            self.player!.delegate = self
            try! player!.start(withClientId: auth.clientID)
            self.player!.login(withAccessToken: authSession.accessToken)
        }
    }
    
    // action for the Play button
    @objc func playTrack(sender: UIButton!) {
        
        let track = "spotify:track:" + Queue.instance.nodeAt(atIndex: Queue.instance.getPoint())
        
        if(playing){
            pause()
            playing = false
        }
        else{
            play(track)
            playing = true
        }
        
//        if(playing){
//            self.player?.setIsPlaying(false ,callback: { (error) in
//                if (error != nil) {
//                    print("paused")
//                }
//            })
//            playing = false
//        }
//        else{
//            print(track)
//            self.player?.playSpotifyURI(track, startingWith: 0, startingWithPosition: 0, callback: { (error) in
//                if (error != nil) {
//                    print("playing!")
//                }
//            })
//            playing = true
//        }
    }
    
    
    // action for the Play button
    @objc func backTrack(sender: UIButton!) {
        print("Back Track!")
    }
    
    func play(_ track: String){
        self.player?.playSpotifyURI(track, startingWith: 0, startingWithPosition: TimeInterval(startTime), callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
    }
    
    func pause(){
        self.player?.setIsPlaying(false ,callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

