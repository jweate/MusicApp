//
//  BrowseController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class BrowseController: UINavigationController {

    var swipeDeck = SwipeDeckController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [swipeDeck]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
