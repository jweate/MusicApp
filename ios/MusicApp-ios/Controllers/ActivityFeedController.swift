//
//  ActivityFeedController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/8/18.
//  Authored by Tomy Doan
//  Copyright © 2018 Jacob Weate. All rights reserved.
//



import UIKit

class ActivityCell : UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ActivityFeedController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    let demoData = """
{
    "events": [
        {
            "idEvent": "1",
            "idUser": "22gq726ts4zr5z2csk5k5ewwa",
            "eventType": "UserAddedSong",
            "trackName": "Supermodel",
            "artistName": "SZA"
        },
    ]
}
"""
    public var eventList: LinkedList<Event>?
    var tableView = UITableView()
    var playback: PlaybackController?
    var tabBarHeight: CGFloat?
    var userIDName: String?
    var token: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        token = RootController.firstTimeSession?.accessToken
        self.title = "Activity"
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
                print("AYO WTF IS GOOD")
            } else {
                jsonData = data
            }
            semaphore.signal()
            }.resume()
        semaphore.wait()
        
        let jsonDict: NSDictionary = (try! JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
        
        let userID = jsonDict["id"]! as? String
        userIDName = userID
        print("\(userID!)")
        
        eventList = getEventList()
        tableView.dataSource = self
        tableView.delegate = self
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0).isActive = true
        
        self.view.addSubview((playback?.view)!)
        playback?.view.translatesAutoresizingMaskIntoConstraints = false
        playback?.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        playback?.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        playback?.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1*tabBarHeight!).isActive = true
        
        //let myCell = UITableViewCell.init(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cellId")
        tableView.register(ActivityCell.self, forCellReuseIdentifier: "cellId")
    }
    
    func getEventList() -> LinkedList<Event> {
        let list = LinkedList<Event>()
        let url = URL(string: "http://musicappapin-env.bgffh6vnm9.us-east-2.elasticbeanstalk.com/getConEvents?idUser=\(userIDName!)")
        print(userIDName)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        var jsonData: Data?
        jsonData = self.demoData.data(using: .utf8)
        // Need semaphore because dataTask is asynchronous
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { data,response,err in
            let resp = response as! HTTPURLResponse
            if resp.statusCode != 200 {
                // Use sample data if response status code is not 200
                jsonData = self.demoData.data(using: .utf8)
            } else {
                jsonData = data
            }
            semaphore.signal()
            }.resume()
        semaphore.wait()
        
        let decoder = JSONDecoder()
        let rawEventList = try! decoder.decode([RawEvent].self, from: jsonData!)
        
        for rawEvent in rawEventList {
            let event = Event(rawEvent)
            list.append(value: event)
        }
        return list
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
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    // determines the amount of rows in View
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return eventList!.size
    }
    
    // populates individual Cells
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        //token = RootController.firstTimeSession?.accessToken
        let event = eventList?.nodeAt(atIndex: indexPath.row)?.value
        print(event!.idUser)
        let url = URL(string: "https://api.spotify.com/v1/users/\(event!.idUser)")
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
                jsonData = self.demoData.data(using: .utf8)
            } else {
                print("hello i am here~!")
                jsonData = data
            }
            semaphore.signal()
            }.resume()
        semaphore.wait()
        
        let jsonDict: NSDictionary = (try! JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
        var userName: String?
        if jsonDict["display_name"] is NSNull {
            userName = jsonDict["id"] as? String
            userIDName = userName
        }
        else {
            userName = jsonDict["display_name"] as? String
            userIDName = userName
        }
        let newImg = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        newImg.contentMode = .scaleAspectFit
        let imageArray = jsonDict["images"] as? [[String:Any]]
        if imageArray == nil || imageArray!.count == 0 {
            newImg.image = #imageLiteral(resourceName: "ic_account_box_48pt")
            cell.imageView?.image = resizeImage(image: newImg.image!)
        }
        else {
            let nestedDictionary = imageArray![0] as [String:Any]
            let image = nestedDictionary["url"]
            print(image!)
            let imageURL = URL(string: image! as! String)
            let imageData = try? Data(contentsOf: imageURL!)
            
            if let realImage = UIImage(data: imageData!) {
                cell.imageView?.image = resizeImage(image: realImage)
            }
        }
        switch event?.eventType {
        case "UserAddedConnection"?:
            cell.textLabel?.text = "\(userName!) has added another user as a connection"
        case "UserAddedSong"?:
            cell.textLabel?.text = "\(userName!) has added a new song to their queue"
            cell.detailTextLabel?.text = "\(event!.artistName) - \(event!.trackName)"
        default:
            // maybe # of songs listened to?
            print("hi")
        }
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.minimumScaleFactor = 0
        cell.imageView?.contentMode = .scaleAspectFit
        
        return cell
    }
    
    func resizeImage(image: UIImage) -> UIImage {
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
        let newSize = CGSize(width: 40, height: 40)
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
}

