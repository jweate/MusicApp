//
//  QueueListController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/8/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class QueueListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView = UITableView()
    var playback = PlaybackController()
    
    var tabBarHeight: CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // set up editting environment
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.title = "Queue"
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0).isActive = true
        
        self.view.addSubview(playback.view)
        playback.view.translatesAutoresizingMaskIntoConstraints = false
        playback.view.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        playback.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        playback.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1*tabBarHeight!).isActive = true
        
        // register Cells - located at bottom of file
        tableView.register(MyCell.self, forCellReuseIdentifier: "cellId")
        
    }
    
    override func setEditing(_ editing: Bool,
                             animated: Bool) {
        super.setEditing(editing, animated: editing)
        tableView.setEditing(editing, animated: animated)
    }

    // determines the amount of rows in View
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Queue.instance.count()
    }

    // populates individual Cells
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        cell.textLabel?.text = Queue.instance.nodeAt(atIndex: indexPath.row).title

        cell.imageView?.image = UIImage(named: "SS3")
        
        return cell
    }
    
    // allows user to edit the order of the Queue
    func tableView(_ tableView: UITableView,
                   moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        let movedObject = Queue.instance.nodeAt(atIndex: sourceIndexPath.row)
        Queue.instance.removeAt(atIndex: sourceIndexPath.row)
        Queue.instance.insertAt(String: movedObject, atIndex: destinationIndexPath.row)
        // To check for correctness enable: self.tableView.reloadData()
    }
    
    // responsible for switches between Edit and View mode
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if (self.editButtonItem.isEnabled){
            return .delete
        } else {
            return .none
        }
    }
    // indents the cells when in Edit mode
    func tableView(_ tableView: UITableView,
                   shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        if (self.editButtonItem.isEnabled) {
            return true
        } else {
            return false
        }
    }
    
    // Deletes the cells from the Table View and the Queue instance
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        Queue.instance.removeAt(atIndex: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        print(Queue.instance.count())
    }
    
}

// Individual cells in the Table View
class MyCell : UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
