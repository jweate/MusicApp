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
    public var auth: AuthController?
    var isAuth = false
    static var firstTimeSession: SPTSession?
    public var user: SPTUser?
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        // determines if user needs to be authenticated
        if (!isAuth){
            self.present(auth!, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = QueueController()
        let browse = BrowseController()
        let activity = ActivityController()
        auth = AuthController()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateAfterFirstLogin), name: Notification.Name("LoggedIn"), object: nil)
        
        
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
        //queue.queueList.tabBarHeight = tabBar.frame.height
        
        viewControllers = [queue, browse, activity]
        tabBar.barTintColor = UIColor(hexString: "333333")
        tabBar.tintColor = UIColor(hexString: "B104FF")

//        Queue.instance.append(track: Track("Sample Song 1", "4iV5W9uYEdYUVa79Axb7Rh"))
//        Queue.instance.append(track: Track("Sample Song 2", "6JzzI3YxHCcjZ7MCQS2YS1"))
//        Queue.instance.append(track: Track("Sample Song 3", "58s6EuEYJdlb0kO7awm3Vp"))
//        Queue.instance.append(track: Track("Sample Song 4", "6JzzI3YxHCcjZ7MCQS2YS1"))
//        Queue.instance.append(track: Track("Sample Song 5", "58s6EuEYJdlb0kO7awm3Vp"))
        
        print(Queue.instance.count())
    }
    
    @objc func updateAfterFirstLogin () {
        os_log("updated")
        isAuth = true
        if let sessionObj:AnyObject = UserDefaults.standard.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            RootController.firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as? SPTSession
            self.dismiss(animated: true)
            NotificationCenter.default.post(name: Notification.Name(rawValue: "Playtime"), object: nil)
            //print(RootController.firstTimeSession?.accessToken)
//            SPTUser.requestCurrentUser(withAccessToken: RootController.firstTimeSession?.accessToken, callback: { (error, request) in
//                if(error == nil){
//                    let user = request as! SPTUser
//                    print(user.displayName)
//                    
//                }
//            })
        }
    }
    

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
