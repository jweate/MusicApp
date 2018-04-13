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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
