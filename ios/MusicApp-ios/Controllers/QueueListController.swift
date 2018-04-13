//
//  QueueListController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/8/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class QueueListController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        
        self.title = "Queue"
        
        // set up editting environment
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.isEditing = false
        
        // register Cells - located at bottom of file
        tableView.register(MyCell.self, forCellReuseIdentifier: "cellId")
        
    }

    // determines the amount of rows in View
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Queue.instance.count()
    }

    // populates individual Cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        cell.textLabel?.text = Queue.instance.nodeAt(atIndex: indexPath.row)

        cell.imageView?.image = UIImage(named: "SS3")
        
        return cell
    }
    
    // allows user to edit the order of the Queue
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = Queue.instance.nodeAt(atIndex: sourceIndexPath.row)
        Queue.instance.removeAt(atIndex: sourceIndexPath.row)
        Queue.instance.insertAt(String: movedObject, atIndex: destinationIndexPath.row)
        // To check for correctness enable: self.tableView.reloadData()
    }
    
    // responsible for switches between Edit and View mode
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if(self.editButtonItem.isEnabled){
            return .delete
        }
        else{
            return .none
        }
    }
    // indents the cells when in Edit mode
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        if(self.editButtonItem.isEnabled){
            return true
        }
        else{
            return false
        }
    }
    
    // Deletes the cells from the Table View and the Queue instance
    override func tableView(_ tableView: UITableView,
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
