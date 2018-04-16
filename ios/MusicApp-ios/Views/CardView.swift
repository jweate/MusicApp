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
    
    func setup() {
        // Background
        backgroundColor = UIColor(hexString: "333333")
        
        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 1.5)
        layer.shadowRadius = 4.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        // Corner Radius
        layer.cornerRadius = 10.0;
        
        /*
        // Track Setup
        
        titleLabel = UILabel()
        artistLabel = UILabel()
        albumLabel = UILabel()
        
        // Set up views if editing an existing Meal.
        if let track = track {
            titleLabel!.text = track.title!
            artistLabel!.text = track.artist!
            albumLabel!.text = track.album!
            imageView = UIImageView(image: track.artwork)
        }
        */
    }
}
