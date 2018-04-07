//
//  RootController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

/*
 * This class contains and manages the entire app
 *   - manages the top-level navigation
 *   - checks for authentication
 *   - maybe other stuff?
 */
class RootController: UITabBarController {
    
    // MARK: Properties
    var auth: AuthController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = QueueController()
        let browse = BrowseController()
        let activity = ActivityController()
        
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
