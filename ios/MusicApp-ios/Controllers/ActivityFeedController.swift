//
//  ActivityFeedController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/8/18.
//  Authored by Tomy Doan
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

let example_activity_data = """
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

class ActivityFeedController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    public var eventList: LinkedList<Event>?
    var tableView = UITableView()
    var bottomOffset: CGFloat?
    var userIDName: String?
    var token: String?
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ActivityFeedController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor(hexString: "#00ffff")
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutTableView()
        reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        reloadData()
        tableView.reloadData()
    }
    
    func layoutTableView() {
        
        self.tableView.backgroundColor = .black
        
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        //tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1 * bottomOffset!).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0).isActive = true
        
        tableView.rowHeight = 76
        tableView.separatorStyle = .none
    }
    
    func getEventList() -> LinkedList<Event> {
        let list = LinkedList<Event>()
        let url = URL(string: "http://musicappapin-env.bgffh6vnm9.us-east-2.elasticbeanstalk.com/getConEvents?idUser=\(userIDName!)")
        print(userIDName!)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        var jsonData: Data?
        jsonData = example_activity_data.data(using: .utf8)
        // Need semaphore because dataTask is asynchronous
        let semaphore = DispatchSemaphore(value: 0)
        URLSession.shared.dataTask(with: request) { data,response,err in
            let resp = response as! HTTPURLResponse
            if resp.statusCode != 200 {
                // Use sample data if response status code is not 200
                jsonData = example_activity_data.data(using: .utf8)
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
    
    func reloadData() {
        
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
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.84).isActive = true
        self.tableView.addSubview(self.refreshControl)
        
        tableView.register(ActivityFeedCell.self, forCellReuseIdentifier: "ActivityFeedCell")
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
        
        let cellIdentifier = "ActivityFeedCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ActivityFeedCell else {
            fatalError("The dequeued cell is not an instance of ActivityFeedCell.")
        }
        
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
                jsonData = example_activity_data.data(using: .utf8)
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
                cell.eventImageView.image = resizeImage(image: realImage)
            }
        }
        switch event?.eventType {
        case "UserAddedConnection"?:
            cell.eventLabel.text = "\(userName!) has added another user as a connection"
        case "UserAddedSong"?:
            cell.eventLabel.text = "\(userName!) has added a new song to their queue"
            cell.eventDetailLabel.text = "\(event!.artistName) - \(event!.trackName)"
        default:
            // maybe # of songs listened to?
            print("hi")
        }
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.minimumScaleFactor = 0
        cell.imageView?.contentMode = .scaleAspectFit
        
        return cell
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        reloadData()
        self.tableView.reloadData()
        refreshControl.endRefreshing()
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

// Individual cells in the Table View
class ActivityFeedCell : UITableViewCell {
    
    var eventLabel = UILabel()
    var eventDetailLabel = UILabel()
    var eventImageView = UIImageView()
    
    var container = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let bgView = UIView(frame: CGRect(x: 0, y: 3, width: 414, height: 76))
        bgView.backgroundColor = .black
        backgroundView = bgView
        
        selectionStyle = .none
        selectedBackgroundView = UIView(frame: CGRect(x: 0, y: 3, width: 414, height: 76))
        selectedBackgroundView?.backgroundColor = .blue
        
        container.frame = CGRect(x: 0, y: 0, width: bgView.frame.width, height: 70)
        container.backgroundColor = .white
        container.layer.masksToBounds = false
        container.layer.cornerRadius = 10.0
        
        contentView.backgroundColor = .clear
        
        layoutImage()
        layoutText()
        
        self.contentView.addSubview(container)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutImage() {
        
        container.addSubview(eventImageView)
        
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 2).isActive = true
        eventImageView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 2).isActive = true
        eventImageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -2).isActive = true
        eventImageView.rightAnchor.constraint(equalTo: container.leftAnchor, constant: container.frame.height - 2).isActive = true
        
        eventImageView.heightAnchor.constraint(equalToConstant: container.frame.height).isActive = true
        eventImageView.widthAnchor.constraint(equalToConstant: container.frame.height).isActive = true
        
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.layer.masksToBounds = true
        eventImageView.layer.cornerRadius = 10
        eventImageView.backgroundColor = .white
    }
    
    func layoutText() {
        
        eventLabel.font = UIFont.boldSystemFont(ofSize: 18)
        eventLabel.textAlignment = .left
        eventLabel.textColor = .black
        eventLabel.numberOfLines = 2
        eventLabel.frame = CGRect(x: 0, y: 0, width: container.frame.width - container.frame.height - 10, height: 20)
        
        container.addSubview(eventLabel)
        
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        eventLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 2).isActive = true
        eventLabel.leftAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: 5).isActive = true
        
        
        
        eventDetailLabel.font = UIFont.italicSystemFont(ofSize: 12)
        eventDetailLabel.textAlignment = .left
        eventDetailLabel.textColor = .darkGray
        eventDetailLabel.numberOfLines = 1
        eventDetailLabel.frame = CGRect(x: 0, y: 0, width: container.frame.width, height: 15)
        
        container.addSubview(eventDetailLabel)
        
        eventDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        eventDetailLabel.topAnchor.constraint(equalTo: eventLabel.bottomAnchor, constant: 2).isActive = true
        eventDetailLabel.leftAnchor.constraint(equalTo: eventImageView.rightAnchor, constant: 10).isActive = true
        
        
    }
    
}


