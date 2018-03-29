//
//  ViewController.swift
//  MusicApp-ios
//
//  Created by Jacob Weate on 3/29/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, SPTAudioStreamingPlaybackDelegate, SPTAudioStreamingDelegate {

    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    var player: SPTAudioStreamingController?
    var loginUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        os_log("setting up")
        setup()
        os_log("calling first login")
        NotificationCenter.default.addObserver(self, selector: #selector(updateAfterFirstLogin), name: Notification.Name("LoggedIn"), object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @objc func updateAfterFirstLogin () {
        os_log("updated after first")
        if let sessionObj:AnyObject = UserDefaults.standard.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.session = firstTimeSession
            initializePlayer(authSession: session)
        }
    }
        
        func initializePlayer(authSession:SPTSession){
            os_log("initialized")
            if self.player == nil {
                self.player = SPTAudioStreamingController.sharedInstance()
                self.player!.playbackDelegate = self
                self.player!.delegate = self
                try! player!.start(withClientId: auth.clientID)
                self.player!.login(withAccessToken: authSession.accessToken)
            }
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setup(){
        SPTAuth.defaultInstance().clientID = "e442cd6018ed442793042372fc7a1b1e"
        SPTAuth.defaultInstance().redirectURL = URL(string: "MusicApp-ios://returnAfterLogin")
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = SPTAuth.defaultInstance().spotifyWebAuthenticationURL()
        os_log("set up complete")
    }
    
//    uncommenting will play music on sign in 
//    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
//        // after a user authenticates a session, the SPTAudioStreamingController is then initialized and this method called
//        print("logged in")
//        self.player?.playSpotifyURI("spotify:track:58s6EuEYJdlb0kO7awm3Vp", startingWith: 0, startingWithPosition: 0, callback: { (error) in
//            if (error != nil) {
//                print("playing!")
//            }
//        })
//    }

    @IBOutlet weak var SignIn: UIButton!
    @IBAction func SignIn(_ sender: UIButton) {
        if UIApplication.shared.openURL(loginUrl!) {
            os_log("sign in")
            if auth.canHandle(auth.redirectURL) {
                // To do - build in error handling
            }
        }
    }
    
}

