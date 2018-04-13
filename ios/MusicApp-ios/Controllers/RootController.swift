//
//  RootController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit
import os.log

/*
 * This class contains and manages the entire app
 *   - manages the top-level navigation
 *   - checks for authentication
 *   - maybe other stuff?
 */
class RootController: UITabBarController {
    
    // MARK: Properties
    //var auth: AuthController?
    //var isAuth = false
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        /*
        // determines if user needs to be authenticated
        if (!isAuth){
            self.present(auth!, animated: true)
        }
        */
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = QueueController()
        let browse = BrowseController()
        let activity = ActivityController()
        //auth = AuthController()
        
        //NotificationCenter.default.addObserver(self, selector: #selector(updateAfterFirstLogin), name: Notification.Name("LoggedIn"), object: nil)
        
        
        queue.tabBarItem = UITabBarItem(title: "queue",
                                        image: UIImage(named: "icon-queue-inactive"),
                                        selectedImage: UIImage(named: "icon-queue-active"))
        queue.tabBarItem.tag = 0
        browse.tabBarItem = UITabBarItem(title: "browse",
                                         image: UIImage(named: "icon-browse-inactive"),
                                         selectedImage: UIImage(named: "icon-browse-active"))
    
        browse.tabBarItem.tag = 1
        activity.tabBarItem = UITabBarItem(title: "connect",
                                           image: UIImage(named: "icon-connect-inactive"),
                                           selectedImage: UIImage(named: "icon-connect-active"))
        activity.tabBarItem.tag = 2
        
        queue.tabBarHeight = tabBar.frame.height
        
        viewControllers = [queue, browse, activity]
        tabBar.barTintColor = UIColor(hexString: "333333")
        tabBar.tintColor = UIColor(hexString: "B104FF")
        //tabBar.backgroundImage = UIImage()
    }
    
    /*
    @objc func updateAfterFirstLogin () {
        os_log("updated")
        isAuth = true
        if let sessionObj:AnyObject = UserDefaults.standard.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            self.dismiss(animated: true)
//            self.session = firstTimeSession
//            initializePlayer(authSession: session)
        }
    }
     */
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
