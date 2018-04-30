//
//  ActivityController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class ConnectController: UINavigationController {
    
    var activityFeed = ActivityFeedController()
    var myProfile = MyProfileController()
    var bottomOffset: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityFeed.navigationItem.setRightBarButton(UIBarButtonItem(title: "My Profile",
                                                                      style: .plain,
                                                                      target: self,
                                                                      action: #selector(navigateToMyProfile)),
                                                      animated: true)
        
        activityFeed.bottomOffset = bottomOffset
        myProfile.bottomOffset = bottomOffset
        
        self.viewControllers = [activityFeed]
        
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor(hexString: "#0a0a0a")
        self.navigationBar.tintColor = UIColor(hexString: "#00ffff")
        self.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hexString: "#f5f5f5")
        ]
        
    }
    
    @objc func navigateToMyProfile(_ sender: UIBarButtonItem) {
        self.pushViewController(myProfile, animated: true)
    }
    
}

