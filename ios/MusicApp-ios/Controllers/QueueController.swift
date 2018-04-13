//
//  QueueController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class QueueController: UIViewController {
    
    var queueList = QueueListController()
    var playback = PlaybackController()
    
    var tabBarHeight: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewController(queueList)
        view.addSubview(queueList.view)
        
        addChildViewController(playback)
        view.addSubview(playback.view)
        playback.view.translatesAutoresizingMaskIntoConstraints = false
        playback.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        playback.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        playback.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1*tabBarHeight!).isActive = true
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

