//
//  QueueController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class QueueController: UINavigationController {
    
    var queueList = QueueListController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [queueList]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
