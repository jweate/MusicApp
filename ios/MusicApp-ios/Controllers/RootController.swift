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
class RootController: UITabBarController {
    
    // MARK: Properties
    var auth: AuthController?
    var isAuth = false
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        // determines if user needs to be authenticated
        if (!isAuth){
            self.present(auth!, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = QueueController()
        let browse = BrowseController()
        let activity = ActivityController()
        auth = AuthController()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateAfterFirstLogin), name: Notification.Name("LoggedIn"), object: nil)
        
        
        queue.tabBarItem = UITabBarItem(title: "Queue", image: UIImage(named: "icon-spotify"), selectedImage: UIImage(named: "icon-spotify"))
        queue.tabBarItem.tag = 0
        browse.tabBarItem = UITabBarItem(title: "Browse", image: UIImage(named: "icon-spotify"), selectedImage: UIImage(named: "icon-spotify"))
        browse.tabBarItem.tag = 1
        activity.tabBarItem = UITabBarItem(title: "Activity", image: UIImage(named: "icon-spotify"), selectedImage: UIImage(named: "icon-spotify"))
        activity.tabBarItem.tag = 2
        
        viewControllers = [queue, browse, activity]
        tabBar.barTintColor = .clear
        tabBar.backgroundImage = UIImage()
    }
    
    @objc func updateAfterFirstLogin () {
        os_log("updated")
        isAuth = true
        if let sessionObj:AnyObject = UserDefaults.standard.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.dismiss(animated: true)
//            self.session = firstTimeSession
//            initializePlayer(authSession: session)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
