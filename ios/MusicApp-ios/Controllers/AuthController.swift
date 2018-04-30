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
    
    var loginButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginButton()
        setup()
    }
    
    func setupLoginButton() {
        
        // initialize button
        loginButton = UIButton(type: .system)
        
        // pre-drawing configurations
        loginButton!.tintColor = UIColor.white
        loginButton!.backgroundColor = UIColor(hexString: "#1DB954")
        
        loginButton!.setTitle("LOGIN WITH SPOTIFY", for: .normal)
        loginButton!.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        
        loginButton!.setImage(UIImage(named: "icon-spotify"), for: .normal)
        loginButton!.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15)
        loginButton!.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0)
        
        // handler configuration
        loginButton!.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        // draw
        self.view.addSubview(loginButton!)
        
        // post-drawing configurations
        loginButton!.layer.cornerRadius = 20
        loginButton!.translatesAutoresizingMaskIntoConstraints = false
        loginButton!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        loginButton!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        loginButton!.heightAnchor.constraint(equalToConstant: 40).isActive = true
        loginButton!.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
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
        if UIApplication.shared.canOpenURL(loginUrl!) {
            UIApplication.shared.open(loginUrl!)
        }
        else if auth.canHandle(auth.redirectURL) {
            // To do - build in error handling
        }
    }
    
}
