//
//  QueueController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class QueueController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tabBarItem = UITabBarItem(title: "Queue", image: UIImage(named: "icon-spotify"), selectedImage: UIImage(named: "icon-spotify"))
        //self.tabBarItem.tag = 0
        
        view.backgroundColor = .white
        
        let placeholderText = UILabel()
        placeholderText.text = "Queue View"
        view.addSubview(placeholderText)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
