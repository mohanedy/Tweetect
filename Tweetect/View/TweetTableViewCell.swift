//
//  TweetTableViewCell.swift
//  Tweetect
//
//  Created by Mohaned Yossry on 5/12/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit
import SDWebImage
class TweetTableViewCell: UITableViewCell {
    
    var tweet:TweetDatum?{
        didSet{
            usernameLabel.text = "@\(tweet!.user.screenName)"
            nameLabel.text = tweet?.user.name
            tweetLabel.text = tweet?.text
            avatarImage.sd_setImage(with: URL(string: tweet!.user.profileImageURLHTTPS), completed: nil)
        }
    }
    
    var feel:TweetFeel?{
        didSet{
            feelImageView.image = UIImage(named: feel!.rawValue)
        }
    }
    
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var feelImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.layer.cornerRadius = 30
        
    }
    
   
    
}
enum TweetFeel: String{
    case positive = "Pos"
    case negative = "Neg"
    case neutral = "Neutral"
    
   
    
    static func initialize(stringValue: String)-> TweetFeel {
        switch stringValue {
        case TweetFeel.positive.rawValue:
            return TweetFeel.positive
        case TweetFeel.negative.rawValue:
            return TweetFeel.negative
            
        case TweetFeel.neutral.rawValue:
            return TweetFeel.neutral
            
        default:
            return TweetFeel.neutral
        }
    }
    
}
