//
//  SwipeDeckController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/8/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit


class SwipeDeckController: UIViewController {
    
    var cardView:UIView!
    var panGestureRecognizer:UIPanGestureRecognizer!
    var originalPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Browse"
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector(("panGestureRecognized:")))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        self.cardView = createCardView()
        self.view.addSubview(cardView)
        
    }
    
    func createCardView() -> UIView {
        let width = self.view.frame.width * 0.7
        let height = self.view.frame.height * 0.5
        let rect = CGRect(x:0, y:0, width: width, height: height)
        
        let tempCardView = UIView(frame: rect)
        tempCardView.backgroundColor = UIColor.blue
        tempCardView.layer.cornerRadius = 8;
        tempCardView.layer.shadowOffset = CGSize(width:7, height:7);
        tempCardView.layer.shadowRadius = 5;
        tempCardView.layer.shadowOpacity = 0.5;
        return tempCardView
    }

    override func viewWillLayoutSubviews() {
        cardView.center = self.view.center
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

