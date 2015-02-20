//
//  TweetTableViewCell.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/19/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.profileImage.layer.cornerRadius = 5
        self.profileImage.clipsToBounds = true
        self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTweet(tweet: Tweet){
        self.profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl));
        self.tweetLabel.text = tweet.text
        self.userLabel.text = tweet.user!.name
        self.handleLabel.text = tweet.user!.screenName
        self.createdAtLabel.text = tweet.createdAt?.shortTimeAgoSinceNow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
    }

}
