//
//  QueueController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class QueueController: UINavigationController {
    
    var rootVC = QueueListController()
    //var queueList = QueueListController()
    //var playback = PlaybackController()
    
    var tabBarHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        rootVC.tabBarHeight = tabBarHeight!
        self.viewControllers = [rootVC]
        
        self.navigationBar.barTintColor = UIColor(hexString: "#333333")
        self.navigationBar.tintColor = UIColor(hexString: "#00ffff")
        self.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hexString: "#f5f5f5")
        ]
    }
    
}
