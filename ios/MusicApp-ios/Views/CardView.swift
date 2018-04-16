import UIKit

class CardView: UIView {
    
    var track: Track?
    
    var titleLabel: UILabel?
    var artistLabel: UILabel?
    var albumLabel: UILabel?
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
        
        titleLabel!.text = track.title
        artistLabel!.text = track.artist
        albumLabel!.text = track.album
        imageView = UIImageView(image: track.artwork)
        
        self.addSubview(imageView!)
        imageView!.translatesAutoresizingMaskIntoConstraints = false
        imageView!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView!.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100).isActive = true
        
        titleLabel!.textColor = .white
        self.addSubview(titleLabel!)
        imageView!.translatesAutoresizingMaskIntoConstraints = false
        titleLabel!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel!.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 50).isActive = true
        
        artistLabel!.textColor = .white
        self.addSubview(artistLabel!)
        imageView!.translatesAutoresizingMaskIntoConstraints = false
        artistLabel!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        artistLabel!.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 75).isActive = true
        
        albumLabel!.textColor = .white
        self.addSubview(albumLabel!)
        imageView!.translatesAutoresizingMaskIntoConstraints = false
        albumLabel!.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        albumLabel!.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 100).isActive = true
        
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
