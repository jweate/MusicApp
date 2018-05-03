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
    var index = 0
//    var tracks: LinkedList<Track>?
    var newConnList: [String]?
    var queueList = QueueListController()
    var swipeView = ZLSwipeableView()
    var bottomOffset: CGFloat?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Browse"
        
        // This should be moved to when you first login
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
                    // jsonData = self.demoData.data(using: .utf8)
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
        // -------------------------------------------------
        
        swipeView.numberOfActiveView = 8
        newConnList = stack.newConnList
        
        self.view.addSubview(swipeView)
        swipeView.translatesAutoresizingMaskIntoConstraints = false
        swipeView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        swipeView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1 * bottomOffset!).isActive = true
        swipeView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8).isActive = true
        swipeView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        
        setupSwipeViewHandlers(userID!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        swipeView.nextView = {
            return self.nextCardView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func setupSwipeViewHandlers(_ userID: String) {
        
        swipeView.didStart = {view, location in
            print("Did start swiping view at location: \(location)")
        }
        swipeView.swiping = {view, location, translation in
            print("Swiping at view location: \(location) translation: \(translation)")
        }
        swipeView.didEnd = {view, location in
            print("Did end swiping view at location: \(location)")
        }
        swipeView.didSwipe = {view, direction, vector in
            print("Did swipe view in direction: \(direction), vector: \(vector)")
            if (direction.description == "Right") {
                print("Swipe Right")
                if let cardView = view as? CardView {
                    print("Got card view")
                    self.queue.append(track: cardView.track!)
                    var postEventDetails = [String]()
                    postEventDetails.append("UserAddedSong")
                    postEventDetails.append(cardView.track!.id)
                    postEventDetails.append(cardView.track!.title)
                    postEventDetails.append(cardView.track!.artists.joined(separator: ", "))
                    postEventDetails.append(userID)
                    let eventUrl = "http://musicappapin-env.bgffh6vnm9.us-east-2.elasticbeanstalk.com/"
                    self.makeEventPost(postString: postEventDetails, urlString: eventUrl)
                    
                    let likeUrl = "http://musicappapin-env.bgffh6vnm9.us-east-2.elasticbeanstalk.com/addLiked"
                    self.makeLikePost(userID: userID, songID: cardView.track!.id, liked: 1, urlString: likeUrl)
                    
                } else {
                    fatalError("Error")
                }
            } else if (direction.description == "Left") {
                if let cardView = view as? CardView {
                    let likeUrl = "http://musicappapin-env.bgffh6vnm9.us-east-2.elasticbeanstalk.com/addLiked"
                    self.makeLikePost(userID: userID, songID: cardView.track!.id, liked: 0, urlString: likeUrl)
                }
            }
        }
        swipeView.didCancel = {view in
            print("Did cancel swiping view")
        }
        swipeView.didTap = {view, location in
            print("Did tap at location \(location)")
        }
        swipeView.didDisappear = { view in
            print("Did disappear swiping view")
        }
        
    }
    
    func nextCardView() -> UIView? {
        if stack.trackList.isEmpty {
            // TODO
            // get new recommendations
            return nil
        }
        
        let currTrack = stack.pop()
        let cardView = CardView(frame: swipeView.bounds, track: currTrack!)
        
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
    
    func makeLikePost(userID: String, songID: String, liked: Int, urlString: String) {
        let url = URL(string: urlString+"?idUser=\(userID)&SongID=\(songID)&liked=\(liked)")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {          // check for fundamental networking error
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
