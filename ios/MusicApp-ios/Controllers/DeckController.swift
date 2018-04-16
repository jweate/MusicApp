//
//  BrowseController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class SwipeDeckController: UIViewController {
    
    var swipeableView: ZLSwipeableView!
    var loadCardsFromXib = false
    var colorIndex = 0
    
    var colors = [
        "Turquoise",
        "Green Sea",
        "Emerald",
        "Nephritis",
        "Peter River",
        "Belize Hole",
        "Amethyst",
        "Wisteria",
        "Wet Asphalt",
        "Midnight Blue",
        "Sun Flower",
        "Orange",
        "Carrot",
        "Pumpkin",
        "Alizarin",
        "Pomegranate",
        "Clouds",
        "Silver",
        "Concrete",
        "Asbestos"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Queue"
        
        swipeableView = ZLSwipeableView()
        self.view.addSubview(swipeableView)
        swipeableView.translatesAutoresizingMaskIntoConstraints = false
        swipeableView!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        swipeableView!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        swipeableView!.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8).isActive = true
        swipeableView!.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        
        swipeableView.didStart = {view, location in
            print("Did start swiping view at location: \(location)")
        }
        swipeableView.swiping = {view, location, translation in
            print("Swiping at view location: \(location) translation: \(translation)")
        }
        swipeableView.didEnd = {view, location in
            print("Did end swiping view at location: \(location)")
        }
        swipeableView.didSwipe = {view, direction, vector in
            print("Did swipe view in direction: \(direction), vector: \(vector)")
        }
        swipeableView.didCancel = {view in
            print("Did cancel swiping view")
        }
        swipeableView.didTap = {view, location in
            print("Did tap at location \(location)")
        }
        swipeableView.didDisappear = { view in
            print("Did disappear swiping view")
        }
        
        //        constrain(swipeableView, view) { view1, view2 in
        //            view1.left == view2.left+50
        //            view1.right == view2.right-50
        //            view1.top == view2.top + 120
        //            view1.bottom == view2.bottom - 100
        //        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        swipeableView.nextView = {
            return self.nextCardView()
        }
    }
    
    
    func nextCardView() -> UIView? {
        if colorIndex >= colors.count {
            colorIndex = 0
        }
        
        let cardView = CardView(frame: swipeableView.bounds)
        cardView.backgroundColor = colorForName(colors[colorIndex])
        colorIndex += 1
        
        if loadCardsFromXib {
            let contentView = Bundle.main.loadNibNamed("CardContentView", owner: self, options: nil)?.first! as! UIView
            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.backgroundColor = cardView.backgroundColor
            cardView.addSubview(contentView)
            
            // This is important:
            // https://github.com/zhxnlai/ZLSwipeableView/issues/9
            /*
             // Alternative:
             let metrics = ["width":cardView.bounds.width, "height": cardView.bounds.height]
             let views = ["contentView": contentView, "cardView": cardView]
             cardView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView(width)]", options: .AlignAllLeft, metrics: metrics, views: views))
             cardView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView(height)]", options: .AlignAllLeft, metrics: metrics, views: views))
             */
            //            constrain(contentView, cardView) { view1, view2 in
            //                view1.left == view2.left
            //                view1.top == view2.top
            //                view1.width == cardView.bounds.width
            //                view1.height == cardView.bounds.height
            //            }
        }
        return cardView
    }
    
    func colorForName(_ name: String) -> UIColor {
        let sanitizedName = name.replacingOccurrences(of: " ", with: "")
        let selector = "flat\(sanitizedName)Color"
        return UIColor.perform(Selector(selector)).takeUnretainedValue() as! UIColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
