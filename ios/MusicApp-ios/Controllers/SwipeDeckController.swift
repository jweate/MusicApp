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
    var queueList = QueueListController()
    var tabBarHeight: CGFloat?
    var playback: PlaybackController?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Browse"
        let token = RootController.firstTimeSession?.accessToken
        let url = URL(string: "https://api.spotify.com/v1/me")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
        var jsonData: Data?
        //Need semaphore because dataTask is asynchronous
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { data,response,err in
            let resp = response as! HTTPURLResponse
            if resp.statusCode != 200 {
                // Use sample data if response status code is not 200
                // THIS SHOULD NEVER HAPPEN. IF IT DOES, WE'RE SCREWED.
                //jsonData = self.demoData.data(using: .utf8)
            } else {
                jsonData = data
            }
            semaphore.signal()
            }.resume()
        semaphore.wait()
        
        let jsonDict: NSDictionary = (try! JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
        
        let userID = jsonDict["id"]! as? String
        print("\(userID!)")
        let postUrl = "http://musicappapin-env.bgffh6vnm9.us-east-2.elasticbeanstalk.com/addUser?idUser="
        makePostRequest(postString: "\(userID!)", urlString: postUrl)
        
        swipeableView = ZLSwipeableView()
        
        swipeableView.numberOfActiveView = 8
        
        tracks = stack.toArray()
        
        
        self.view.addSubview(swipeableView)
        swipeableView.translatesAutoresizingMaskIntoConstraints = false
        swipeableView!.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        swipeableView!.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -0.8*tabBarHeight!).isActive = true
        swipeableView!.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.65).isActive = true
        swipeableView!.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        
        self.view.addSubview((playback?.view)!)
        playback?.view.translatesAutoresizingMaskIntoConstraints = false
        playback?.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        playback?.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        playback?.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1*tabBarHeight!).isActive = true
        
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
                if let cardView = view as? CardView {
                    print("Got card view")
                    self.queue.append(track: cardView.track!)
                    var postDetails = [String]()
                    postDetails.append("UserAddedSong")
                    postDetails.append(cardView.track!.id)
                    postDetails.append(cardView.track!.title)
                    postDetails.append(cardView.track!.artists.joined(separator: ", "))
                    postDetails.append(userID!)
                    let eventUrl = "http://musicappapin-env.bgffh6vnm9.us-east-2.elasticbeanstalk.com/"
                    self.makeEventPost(postString: postDetails, urlString: eventUrl)
                } else {
                    fatalError("Error")
                }
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
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        swipeableView.nextView = {
            return self.nextCardView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.addSubview((playback?.view)!)
        playback?.view.translatesAutoresizingMaskIntoConstraints = false
        playback?.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        playback?.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        playback?.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1*tabBarHeight!).isActive = true
    }
    
    
    func nextCardView() -> UIView? {
        if index >= tracks!.count {
            index = 0
        }
        
        let cardView = CardView(frame: swipeableView.bounds, track: tracks![index])
        
        index = index + 1
        
        return cardView
    }
    func makeEventPost(postString: [String], urlString: String) {
        let url : NSString = urlString+"addEvent?EventType=\(postString[0])&SongID=\(postString[1])&trackName=\(postString[2])&artistName=\(postString[3])&idUser=\(postString[4])" as NSString
        let urlStr = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let searchURL : NSURL = NSURL(string: urlStr as! String)!
        print(searchURL)
        var request2 = URLRequest(url: searchURL as URL)
        request2.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request2) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse {  // check for http errors
                if httpStatus.statusCode != 200 {
                    print("statusCode should be 200, but is \(httpStatus.statusCode)")
                    print("response = \(String(describing: response))")
                } else {
                    print("status code is: \(httpStatus.statusCode)")
                }
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
    
    func makePostRequest(postString: String, urlString: String) {
        let postUrl = URL(string: urlString+"\(postString)")
        var request2 = URLRequest(url: postUrl!)
        request2.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request2) { data, response, error in
            guard let data = data, error == nil else {                                                 // check for fundamental networking error
                print("error=\(String(describing: error))")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
    }
}
