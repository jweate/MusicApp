//
//  PlaybackView.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class PlaybackController: UIViewController {
    
    // MARK: Properties
    var playButton: UIButton?
    var skipForwardButton: UIButton?
    var skipBackwardButton: UIButton?
    var trackDurationSlider: UISlider?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexString: "333333")
    
        playButton = UIButton()
        skipForwardButton = UIButton()
        skipBackwardButton = UIButton()
        
        playButton!.backgroundColor = .red
        view.addSubview(playButton!)
        playButton!.translatesAutoresizingMaskIntoConstraints = false
        playButton!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        playButton!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        playButton!.heightAnchor.constraint(equalToConstant: 80).isActive = true
        playButton!.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        
        
        skipForwardButton!.backgroundColor = .red
        view.addSubview(skipForwardButton!)
        skipForwardButton!.translatesAutoresizingMaskIntoConstraints = false
        skipForwardButton!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 100).isActive = true
        skipForwardButton!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        skipForwardButton!.heightAnchor.constraint(equalToConstant: 60).isActive = true
        skipForwardButton!.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        skipBackwardButton!.backgroundColor = .red
        view.addSubview(skipBackwardButton!)
        skipBackwardButton!.translatesAutoresizingMaskIntoConstraints = false
        skipBackwardButton!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -100).isActive = true
        skipBackwardButton!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        skipBackwardButton!.heightAnchor.constraint(equalToConstant: 60).isActive = true
        skipBackwardButton!.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
