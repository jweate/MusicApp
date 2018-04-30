//
//  TabBarController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/29/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    // MARK: Properties
    //var secondItemImageView: UIImageView!
    
    // MARK: Setup Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        //let secondItemView = self.tabBar.subviews[1]
        
        //self.secondItemImageView = secondItemView.subviews.first as! UIImageView
        
        //self.secondItemImageView.contentMode = .center
    }
    
    // MARK: Method Overrides
    //override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
    //    self.secondItemImageView.transform = CGAffineTransform.identity
    //    if item.tag == 1 {
    //        UIView.animate(withDuration: 0.7,
    //                       animations: { () -> Void in
    //                        let rotation = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
    //                        self.secondItemImageView.transform = rotation
    //        },
    //                       completion: nil)
    //    }
    // }


}

extension UITabBarItem {
    func tabBarItemShowingOnlyImage() -> UITabBarItem {
        // offset to center
        self.imageInsets = UIEdgeInsets(top:6,left:0,bottom:-6,right:0)
        // displace to hide
        self.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 30000)
        return self
    }
}

