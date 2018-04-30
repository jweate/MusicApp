//
//  MyProfileController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit
import os.log

class MyProfileController: UIViewController {
    
    // Spotify User object
    var user: SPTUser?
    
    // Spotify User display name
    var name: String?
    
    // User Picture image view
    var imageView = UIImageView()
    
    // Activity Feed table view controller
    var activityFeed = ActivityFeedController()
    
    // Used for view content offset
    var bottomOffset: CGFloat?
    
    
    // MARK: Setup Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Profile"
        let button = UIButton()

        // gets User data from Spotify
        SPTUser.requestCurrentUser(withAccessToken: RootController.firstTimeSession?.accessToken,
                                   callback: { (error, request) in
            if error == nil {
                self.user = request as? SPTUser
                if self.user!.displayName == nil {
                    self.name = "User"
                    
                } else {
                    self.name = self.user!.displayName as String
                }
                
                if self.user!.largestImage == nil {
                    self.imageView.image = UIImage(named: "ic_account_box_48pt")
                    
                } else {
                    let url = URL(string: (self.user!.largestImage.imageURL.absoluteString))
                    self.downloadImage(url: url!)
                }

                button.setTitle(self.name, for: .normal)
            }
        })
        button.setTitleColor(.white, for: .normal)

        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 75).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        layoutImageView()
        layoutActivityFeed()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    // MARK: Subview Layout
    func layoutImageView() {
        self.view.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 100
        imageView.backgroundColor = .white
    }
    
    func layoutActivityFeed() {
        self.view.addSubview(activityFeed.view)
        activityFeed.view.translatesAutoresizingMaskIntoConstraints = false
        activityFeed.view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        activityFeed.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        activityFeed.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1*bottomOffset!).isActive = true
        activityFeed.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }

    // MARK: Data Handlers
    func downloadImage(url: URL) {
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() {
                self.imageView.image = UIImage(data: data)
            }
        }
    }

    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
                completion(data, response, error)
            }.resume()
    }

}
