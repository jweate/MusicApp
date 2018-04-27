//
//  AuthViewController.swift
//  MusicApp
//
//  Created by Jacob Weate on 4/10/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//
import UIKit

class AuthController: UIViewController {
    
    var auth = SPTAuth.defaultInstance()!
    var session:SPTSession!
    var loginUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.setTitle("Sign In with Spotify", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(hexString: "#1DB954")
        
        setup()
    }
    
    
    // setup Spotify environment
    func setup(){
        SPTAuth.defaultInstance().clientID = "e442cd6018ed442793042372fc7a1b1e"
        SPTAuth.defaultInstance().redirectURL = URL(string: "MusicApp-ios://returnAfterLogin")
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope, SPTAuthPlaylistReadPrivateScope, SPTAuthPlaylistModifyPublicScope, SPTAuthPlaylistModifyPrivateScope]
        loginUrl = SPTAuth.defaultInstance().spotifyWebAuthenticationURL()

    }
        
    // action for the Login button
    @objc func buttonAction(sender: UIButton!) {
        
        print("Button tapped")
        if UIApplication.shared.openURL(loginUrl!) {
            if auth.canHandle(auth.redirectURL) {
                // To do - build in error handling
            }
        }
    }
    
}
