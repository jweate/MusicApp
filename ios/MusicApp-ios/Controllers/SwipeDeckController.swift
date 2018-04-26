//
//  BrowseController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/6/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class SwipeDeckController: UIViewController {
    
    var queue = Queue.instance
    var stack = Stack.instance
    var tracks: [Track]?
    var swipeableView: ZLSwipeableView!
    var loadCardsFromXib = false
    var index = 0
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Browse"
        
        swipeableView = ZLSwipeableView()
        
        swipeableView.numberOfActiveView = 8
        
        tracks = stack.toArray()
        
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
            if (direction.description == "Right") {
                print("Swipe Right")
                guard let cardView = view as? CardView else {
                    fatalError("Error")
                }
                self.queue.append(track: cardView.track!)
                //print("Song is is " + self.queue.nodeAt(atIndex: 0).title)
            }
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
        if index >= tracks!.count {
            index = 0
        }
        
        let cardView = CardView(frame: swipeableView.bounds, track: tracks![index])
        
        index = index + 1
        
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
