//
//  AppDelegate.swift
//  MusicApp
//
//  Created by Jacob Weate on 4/10/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit
import os.log

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var auth = SPTAuth()
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // UI shit
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootController = RootController()
        window!.rootViewController = rootController
        window!.makeKeyAndVisible()
        
        // Spotify Shit
        auth.redirectURL = URL(string: "MusicApp-ios://returnAfterLogin")
        auth.sessionUserDefaultsKey = "current session"
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        os_log("fell in")
        // 2- check if app can handle redirect URL
        if auth.canHandle(auth.redirectURL) {
            // 3 - handle callback in closure
            auth.handleAuthCallback(withTriggeredAuthURL: url, callback: { (error, session) in
                // 4- handle error
                if error != nil {
                    print("error!")
                }
                // 5- Add session to User Defaults
                let sessionData = NSKeyedArchiver.archivedData(withRootObject: session as Any)
                UserDefaults.standard.set(sessionData, forKey: "SpotifySession")
                UserDefaults.standard.synchronize()
                // 6 - Tell notification center login is successful
                NotificationCenter.default.post(name: Notification.Name(rawValue: "LoggedIn"), object: nil)
                os_log("made it here")
            })
            return true
        }
        return false
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}

