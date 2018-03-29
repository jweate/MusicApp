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
    
    /*
     * Main
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        NotificationCenter.default.addObserver(self, selector: #selector(updateAfterFirstLogin), name: Notification.Name("LoggedIn"), object: nil)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    /*
     * Called when user originally logins in - creates SPT Player
     */
    @objc func updateAfterFirstLogin () {
        if let sessionObj:AnyObject = UserDefaults.standard.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.session = firstTimeSession
            initializePlayer(authSession: session)
        }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * Sets up credentials of our Application
     */
    func setup(){
        SPTAuth.defaultInstance().clientID = "e442cd6018ed442793042372fc7a1b1e"
        SPTAuth.defaultInstance().redirectURL = URL(string: "MusicApp-ios://returnAfterLogin")
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = SPTAuth.defaultInstance().spotifyWebAuthenticationURL()
    }
    

    @IBOutlet weak var SignIn: UIButton!
    /*
     * Function called when Sign In button is pressed
     */
    @IBAction func SignIn(_ sender: UIButton) {
        if UIApplication.shared.openURL(loginUrl!) {
            if auth.canHandle(auth.redirectURL) {
                // To do - build in error handling
            }
        }
    }
   
   /*
    * Function called when Play button is pressed
    */
    @IBAction func Play(_ sender: UIButton) {

        self.player?.playSpotifyURI("spotify:track:58s6EuEYJdlb0kO7awm3Vp", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
        
    }
    
    /*
     * Function called when Pause button is pressed
     */
    @IBAction func Pause(_ sender: UIButton) {
        self.player?.setIsPlaying(false ,callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
    }
    
    /*
     * Function called when Skip is pressed
     */
    @IBAction func Skip(_ sender: Any) {
        self.player?.playSpotifyURI("spotify:track:6JzzI3YxHCcjZ7MCQS2YS1", startingWith: 0, startingWithPosition: 0, callback: { (error) in
            if (error != nil) {
                print("playing!")
            }
        })
    }
}

