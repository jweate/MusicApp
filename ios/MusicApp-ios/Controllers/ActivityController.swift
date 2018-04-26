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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityFeed.navigationItem.setRightBarButton(UIBarButtonItem(title: "My Profile",
                                                                      style: .plain,
                                                                      target: self,
                                                                      action: #selector(navigateToMyProfile)),
                                                      animated: false)
        
        self.viewControllers = [activityFeed]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func navigateToMyProfile(_ sender: UIBarButtonItem) {
        self.pushViewController(myProfile, animated: false)
    }
    
    

}
