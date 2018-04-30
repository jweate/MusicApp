import UIKit

class CardView: UIView {
    
    var track: Track?
    
    var titleLabel = UILabel()
    var artistLabel = UILabel()
    var albumLabel = UILabel()
    var imageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    convenience init(frame: CGRect, track: Track) {
        self.init(frame: frame)
        setup()
        
        print("Initializing card...")
        print("  title: \(track.title)")
        print("  album: \(track.album)")
        
        // Track Setup
        self.track = track
        titleLabel = UILabel()
        artistLabel = UILabel()
        albumLabel = UILabel()
        
        imageView = UIImageView(image: track.artwork)
        
        self.addSubview(imageView!)
        imageView!.contentMode = .scaleAspectFill
        imageView!.translatesAutoresizingMaskIntoConstraints = false
        imageView!.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        imageView!.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        imageView!.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        imageView!.heightAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        imageView!.layer.masksToBounds = true
        imageView!.layer.cornerRadius = 10
        imageView!.backgroundColor = .white
        
        titleLabel.text = track.title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 1
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 20)
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageView!.bottomAnchor, constant: 10).isActive = true
        
        
        
        
        artistLabel.text = track.artists[0]
        artistLabel.font = UIFont.italicSystemFont(ofSize: 18)
        artistLabel.textAlignment = .center
        artistLabel.textColor = .darkGray
        artistLabel.numberOfLines = 1
        artistLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 20)
        
        self.addSubview(artistLabel)
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        artistLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        artistLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        
        
        albumLabel.text = track.album
        albumLabel.font = UIFont.italicSystemFont(ofSize: 18)
        albumLabel.textAlignment = .center
        albumLabel.textColor = .darkGray
        albumLabel.numberOfLines = 1
        albumLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 20)
        
        self.addSubview(albumLabel)
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        albumLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        albumLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        albumLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        albumLabel.topAnchor.constraint(equalTo: artistLabel.bottomAnchor, constant: 5).isActive = true
        
        /*
        let views: [String: Any] = [
            "imageView": imageView!,
            "titleLabel": titleLabel,
            "artistLabel": artistLabel,
            "albumLabel": albumLabel,
        ]
        
        var allConstraints: [NSLayoutConstraint] = []
        
        let column = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-5-[imageView]-[titleLabel]-[artistLabel]-[albumLabel]-|",
            options: [.alignAllCenterX],
            metrics: nil,
            views: views)
        allConstraints += column
        
        let imageRow = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-5-[imageView(327)]-5-|",
            metrics: nil,
            views: views)
        allConstraints += imageRow
        
        let titleRow = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[titleLabel]-|",
            metrics: nil,
            views: views)
        allConstraints += titleRow
        
        let artistRow = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[artistLabel(==titleLabel)]-|",
            metrics: nil,
            views: views)
        allConstraints += artistRow
        
        let albumRow = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[albumLabel(==titleLabel)]-|",
            metrics: nil,
            views: views)
        allConstraints += albumRow
        
        NSLayoutConstraint.activate(allConstraints)
        */
    }
    
    func setup() {
        // Background
        backgroundColor = UIColor(hexString: "#f8f8f8")
        
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shadowOpacity = 0.25
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Border
        layer.cornerRadius = 10.0;
        self.layer.borderWidth = 5
        self.layer.borderColor = UIColor(hexString: "#f8f8f8").cgColor
        
    }
    
}
