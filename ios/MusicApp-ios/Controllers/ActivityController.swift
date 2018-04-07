//
//  ActivityController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class ActivityController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let activityFeed = ActivityFeedController()
        let myProfile = MyProfileController()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func navigateToMyProfile(_ sender: UIBarButtonItem) {
        self.pushViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
    }

}
