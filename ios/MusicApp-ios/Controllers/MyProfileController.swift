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
    
    var user: SPTUser?
    var imageView = UIImageView()
    var name: String?
    var url: URL?
    var tabBarHeight: CGFloat?
    var playback: PlaybackController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "My Profile"
        let button = UIButton()

        //gets User data from Spotify
        SPTUser.requestCurrentUser(withAccessToken: RootController.firstTimeSession?.accessToken, callback: { (error, request) in
            if(error == nil){
                self.user = request as? SPTUser
                if self.user!.displayName == nil {
                    self.name = "User"
                }
                else {
                    self.name = self.user!.displayName as String
                }
                
                if self.user!.largestImage == nil {
                    self.imageView.image = UIImage(named: "ic_account_box_48pt")
                }
                else {
                    self.url = URL(string: (self.user!.largestImage.imageURL.absoluteString))
                    self.downloadImage(url: self.url!)
                }

                button.setTitle(self.name, for: .normal)

            }
        })
        button.setTitleColor(.white, for: .normal)

        
        self.view.addSubview(button)
        self.view.addSubview(self.imageView)
        
        self.view.addSubview((playback?.view)!)
        playback?.view.translatesAutoresizingMaskIntoConstraints = false
        playback?.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        playback?.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        playback?.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1*tabBarHeight!).isActive = true

        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -75).isActive = true
        button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.imageView.contentMode = .scaleAspectFill
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -150).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.35).isActive = true
        self.imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.imageView.layer.cornerRadius = 10
        self.imageView.layer.masksToBounds = true
        self.imageView.backgroundColor = .white

        }


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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview((playback?.view)!)
        playback?.view.translatesAutoresizingMaskIntoConstraints = false
        playback?.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        playback?.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        playback?.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1*tabBarHeight!).isActive = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
