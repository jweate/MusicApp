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
        print("  artist: \(track.artist)")
        print("  album: \(track.album)")
        
        // Track Setup
        self.track = track
        titleLabel = UILabel()
        artistLabel = UILabel()
        albumLabel = UILabel()
        
        imageView = UIImageView(image: track.artwork)
        
        
        self.addSubview(imageView!)
        imageView!.translatesAutoresizingMaskIntoConstraints = false
        imageView!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView!.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100).isActive = true
        
        
        titleLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 40)
        titleLabel.font = .systemFont(ofSize: 22)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.text = track.title
        titleLabel.numberOfLines = 1
        
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 100).isActive = true
        
        
        
        
        artistLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 40)
        artistLabel.font = .systemFont(ofSize: 18)
        artistLabel.textAlignment = .center
        artistLabel.textColor = .white
        artistLabel.text = track.artist
        artistLabel.numberOfLines = 1
        
        self.addSubview(artistLabel)
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        artistLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        artistLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        artistLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 150).isActive = true
        
        
        
        
        
        albumLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 40)
        albumLabel.font = .systemFont(ofSize: 18)
        albumLabel.textAlignment = .center
        albumLabel.textColor = .white
        albumLabel.text = track.album
        albumLabel.numberOfLines = 1
        
        self.addSubview(albumLabel)
        albumLabel.translatesAutoresizingMaskIntoConstraints = false
        albumLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        albumLabel.widthAnchor.constraint(equalToConstant: self.frame.width).isActive = true
        albumLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        albumLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 200).isActive = true
        
    }
    
    func setup() {
        // Background
        backgroundColor = UIColor(hexString: "#333333")
        
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Corner Radius
        layer.cornerRadius = 10.0;
        
    }
}
