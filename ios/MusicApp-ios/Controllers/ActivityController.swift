//
//  ActivityController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class ActivityController: UINavigationController {
    
    var activityFeed = ActivityFeedController()
    var myProfile = MyProfileController()
    var playback: PlaybackController?
    var tabBarHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityFeed.navigationItem.setRightBarButton(UIBarButtonItem(title: "My Profile",
                                                                      style: .plain,
                                                                      target: self,
                                                                      action: #selector(navigateToMyProfile)),
                                                      animated: true)
        activityFeed.playback = playback
        activityFeed.tabBarHeight = tabBarHeight
        myProfile.playback = playback
        myProfile.tabBarHeight = tabBarHeight
        
        self.viewControllers = [activityFeed]
        
        self.navigationBar.barTintColor = UIColor(hexString: "#333333")
        self.navigationBar.tintColor = UIColor(hexString: "#00ffff")
        self.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hexString: "#f5f5f5")
        ]
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func navigateToMyProfile(_ sender: UIBarButtonItem) {
        self.pushViewController(myProfile, animated: true)
    }
    
    
    
}

