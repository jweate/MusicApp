//
//  QueueListController.swift
//  MusicApp-ios
//
//  Created by Padraic Rowan on 4/8/18.
//  Copyright © 2018 Jacob Weate. All rights reserved.
//

import UIKit

class QueueListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Properties
    // Queue table view instance
    var tableView = UITableView()
    
    // Used for view content offset
    var bottomOffset: CGFloat?
    
    
    // MARK: Setup Overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // table view deligate congifuration
        tableView.dataSource = self
        tableView.delegate = self
        
        // navigation configuration
        self.title = "Queue"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.tableView.backgroundColor = .black

        layoutTableView()
        
        // register Cells - located at bottom of file
        tableView.register(QueueListCell.self, forCellReuseIdentifier: "QueueListCell")
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadRows), name: Notification.Name("PlaybackChange"), object: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    @objc func reloadRows() {
        print("HIIIII")
        tableView.reloadData()
    }
    
    func layoutTableView() {
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1.0).isActive = true
        //tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1 * bottomOffset!).isActive = true
        tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0).isActive = true
        
        //tableView.rowHeight = 76
        tableView.separatorStyle = .none
    }
    
    override func setEditing(_ editing: Bool,
                             animated: Bool) {
        super.setEditing(editing, animated: editing)
        tableView.setEditing(editing, animated: animated)
    }

    // determines the amount of rows in View
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return Queue.instance.size()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == Queue.instance.getPointer() {
            return 130
        } else {
            return 76
        }
    }

    // populates individual Cells
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "QueueListCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? QueueListCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let track = Queue.instance.getAt(atIndex: indexPath.row)!
        
        cell.titleLabel.text = track.title
        cell.artistLabel.text = track.artists[0]
        cell.albumLabel.text = track.album
        cell.artworkImageView.image = track.artwork
        
        if indexPath.row == Queue.instance.getPointer() {
            cell.container.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: 124)
            cell.layoutImage()
            cell.layoutText()
        } else {
            cell.container.frame = CGRect(x: 0, y: 0, width: cell.frame.width, height: 70)
            cell.layoutImage()
            cell.layoutText()
        }
        
        return cell
    }
    
    // allows user to edit the order of the Queue
    func tableView(_ tableView: UITableView,
                   moveRowAt sourceIndexPath: IndexPath,
                   to destinationIndexPath: IndexPath) {
        
        let movedTrack = Queue.instance.removeAt(atIndex: sourceIndexPath.row)!
        Queue.instance.putAt(track: movedTrack, atIndex: destinationIndexPath.row)
        // To check for correctness enable: self.tableView.reloadData()
    }
    
    // responsible for switches between Edit and View mode
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        if (self.editButtonItem.isEnabled) {
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
        print(Queue.instance.size())
    }
    
}

// Individual cells in the Table View
class QueueListCell : UITableViewCell {
    
    var titleLabel = UILabel()
    var artistLabel = UILabel()
    var albumLabel = UILabel()
    var artworkImageView = UIImageView()
    
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
        
        container.addSubview(artworkImageView)
        
        layoutImage()
        layoutText()
        
        self.contentView.addSubview(container)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutImage() {
        artworkImageView.removeFromSuperview()
        
        container.addSubview(artworkImageView)
        
        artworkImageView.translatesAutoresizingMaskIntoConstraints = false
        artworkImageView.topAnchor.constraint(equalTo: container.topAnchor, constant: 2).isActive = true
        artworkImageView.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 2).isActive = true
        artworkImageView.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -2).isActive = true
        artworkImageView.rightAnchor.constraint(equalTo: container.leftAnchor, constant: container.frame.height - 2).isActive = true
        
        artworkImageView.heightAnchor.constraint(equalToConstant: container.frame.height).isActive = true
        artworkImageView.widthAnchor.constraint(equalToConstant: container.frame.height).isActive = true
        
        artworkImageView.contentMode = .scaleAspectFill
        artworkImageView.layer.masksToBounds = true
        artworkImageView.layer.cornerRadius = 10
        artworkImageView.backgroundColor = .white
    }
    
    func layoutText() {
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
        titleLabel.frame = CGRect(x: 0, y: 0, width: container.frame.width, height: 20)
        
        container.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 2).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: artworkImageView.rightAnchor, constant: 5).isActive = true
        
        
        
        
        
        artistLabel.font = UIFont.italicSystemFont(ofSize: 12)
        artistLabel.textAlignment = .left
        artistLabel.textColor = .darkGray
        artistLabel.numberOfLines = 1
        artistLabel.frame = CGRect(x: 0, y: 0, width: container.frame.width, height: 15)
        
        container.addSubview(artistLabel)
        
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2).isActive = true
        artistLabel.leftAnchor.constraint(equalTo: artworkImageView.rightAnchor, constant: 10).isActive = true
        
        
        
        
        albumLabel.font = UIFont.italicSystemFont(ofSize: 12)
        albumLabel.textAlignment = .left
        albumLabel.textColor = .darkGray
        albumLabel.numberOfLines = 1
        albumLabel.frame = CGRect(x: 0, y: 0, width: container.frame.width, height: 15)
        
        container.addSubview(albumLabel)
        
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        albumLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 2).isActive = true
        albumLabel.leftAnchor.constraint(equalTo: artworkImageView.rightAnchor, constant: 10).isActive = true
        
        
    }
    
}
