//
//  RootController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit
import os.log

/*
 * This class contains and manages the entire app
 *   - manages the top-level navigation
 *   - checks for authentication
 *   - maybe other stuff?
 */
class RootController: TabBarController {
    
    // MARK: Properties
    var isAuth = false
    static var firstTimeSession: SPTSession?
    public var user: SPTUser?
    
    var playback = PlaybackController()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateAfterFirstLogin), name: Notification.Name("LoggedIn"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        // determine if user needs to be authenticated
        if (!isAuth) {
            self.present(AuthController(), animated: true)
        }
    }

    @objc func updateAfterFirstLogin() {
        os_log("updated")
        isAuth = true
        if let sessionObj:AnyObject = UserDefaults.standard.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            RootController.firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as? SPTSession
            self.dismiss(animated: true)
            loadTabs()
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Playtime"), object: nil)
        }
    }
    
    func loadTabs() {
        let queue = QueueController()
        let browse = BrowseController()
        let connect = ConnectController()
        
        print((RootController.firstTimeSession?.accessToken)!)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateAfterFirstLogin),
                                               name: Notification.Name("LoggedIn"),
                                               object: nil)
        
        queue.tabBarItem = UITabBarItem(title: "queue",
                                        image: UIImage(named: "icon-queue-inactive"),
                                        selectedImage: UIImage(named: "icon-queue-active"))
            .tabBarItemShowingOnlyImage()
        
        queue.tabBarItem.tag = 0
        browse.tabBarItem = UITabBarItem(title: "browse",
                                         image: UIImage(named: "icon-browse-inactive"),
                                         selectedImage: UIImage(named: "icon-browse-active"))
            .tabBarItemShowingOnlyImage()
        
        browse.tabBarItem.tag = 1
        connect.tabBarItem = UITabBarItem(title: "connect",
                                          image: UIImage(named: "icon-connect-inactive"),
                                          selectedImage: UIImage(named: "icon-connect-active"))
            .tabBarItemShowingOnlyImage()
        connect.tabBarItem.tag = 2
        
        tabBar.isTranslucent = false
        tabBar.barTintColor = UIColor(hexString: "#0a0a0a")
        tabBar.tintColor = UIColor(hexString: "#00ffff")
        
        layoutPlayback()
        
        let bottomOffset = tabBar.frame.height + playback.view.frame.height
        print("Bottom Offset:")
        print(tabBar.frame.height)
        print(playback.view.frame.height)
        print(bottomOffset)
        print(self.view.frame.width)
        print(self.view.frame.height)
        //let bottomOffset = tabBar.frame.height
        queue.bottomOffset = bottomOffset
        browse.bottomOffset = bottomOffset
        connect.bottomOffset = bottomOffset
        
        viewControllers = [queue, browse, connect]
    }
    
    
    func layoutPlayback() {
        view.addSubview(playback.view)
        playback.view.translatesAutoresizingMaskIntoConstraints = false
        playback.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        playback.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        playback.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1 * tabBar.frame.height).isActive = true
    }
    
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
