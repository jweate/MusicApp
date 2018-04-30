//
//  BrowseController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class BrowseController: UINavigationController {
    
    var rootVC = SwipeDeckController()
    
    var bottomOffset: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootVC.bottomOffset = bottomOffset
        
        self.viewControllers = [rootVC]
        
        self.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = UIColor(hexString: "#0a0a0a")
        self.navigationBar.tintColor = UIColor(hexString: "#00ffff")
        self.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor(hexString: "#f5f5f5")
        ]
    }
}
