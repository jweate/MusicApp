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
    var auth = SPTAuth.defaultInstance()!
    var player: SPTAudioStreamingController?
    var session: SPTSession!

    // Playback properties
    var playing = false
    var startTime = TimeInterval(0)
    
    // MARK: Properties
    var playButton = UIButton()
    var skipNextButton = UIButton()
    var skipPrevButton = UIButton()
    var trackDurationSlider: UISlider?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame = CGRect(x: 0, y: 500, width: 300, height: 75)
        view.backgroundColor = UIColor(hexString: "#0a0a0a")
        
        layoutButtons()
        
        // set up button handlers
        playButton.addTarget(self, action: #selector(playTrack), for: .touchUpInside)
        skipNextButton.addTarget(self, action: #selector(skipTrack), for: .touchUpInside)
        skipPrevButton.addTarget(self, action: #selector(backTrack), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(createPlayer), name: Notification.Name("Playtime"), object: nil)
    }
    
    func layoutButtons() {
        
        // layout play/pause button
        playButton.setImage(UIImage(named: "icon-play"), for: .normal)
        view.addSubview(playButton)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        playButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        // layout skip next button
        skipNextButton.setImage(UIImage(named: "icon-skip-next"), for: .normal)
        view.addSubview(skipNextButton)
        skipNextButton.translatesAutoresizingMaskIntoConstraints = false
        skipNextButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 100).isActive = true
        skipNextButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        skipNextButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        skipNextButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        // layout skip prev button
        skipPrevButton.setImage(UIImage(named: "icon-skip-prev"), for: .normal)
        view.addSubview(skipPrevButton)
        skipPrevButton.translatesAutoresizingMaskIntoConstraints = false
        skipPrevButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -100).isActive = true
        skipPrevButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        skipPrevButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        skipPrevButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    // creates the player when after the user authenticates himself
    @objc func createPlayer(){
        self.session = RootController.firstTimeSession!
        initializePlayer(authSession: session)
    }
    
    // initialize the spotify player
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
        if !Queue.instance.isEmpty() {
            let track = "spotify:track:" + Queue.instance.getAt(atIndex: Queue.instance.getPointer())!.id
            
            if (playing) {
                pause()
                playing = false
                startTime = (self.player?.playbackState.position)!
                
            } else {
                play(track)
                playing = true
            }
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "PlaybackChange"), object: nil)
        }
    }
 
    // action for the skip button
    @objc func skipTrack(sender: UIButton!) {
        if !Queue.instance.isEmpty() {
            Queue.instance.skipNext()
            print("pointer is " + String(Queue.instance.getPointer()))
            let track = "spotify:track:" + Queue.instance.getAt(atIndex: Queue.instance.getPointer())!.id
            startTime = 0
            playing = true
            play(track)
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "PlaybackChange"), object: nil)
        }
    }
    
    // action for the back button
    @objc func backTrack(sender: UIButton!) {
        if !Queue.instance.isEmpty() {
            Queue.instance.skipPrev()
            let track = "spotify:track:" + Queue.instance.getAt(atIndex: Queue.instance.getPointer())!.id
            startTime = 0
            playing = true
            play(track)
        }
    }

    // helper function for playing a track
    func play(_ track: String){
        print(Queue.instance.getPointer())
        playButton.setImage(UIImage(named: "icon-pause"), for: .normal)
        
        self.player?.playSpotifyURI(track, startingWith: 0, startingWithPosition: startTime, callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "PlaybackChange"), object: nil)
    }
    
    // helper function for pausing a track
    func pause() {
        playButton.setImage(UIImage(named: "icon-play"), for: .normal)
        self.player?.setIsPlaying(false ,callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
        
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: "PlaybackChange"), object: nil)
    }
    
}

