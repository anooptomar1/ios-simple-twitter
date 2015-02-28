//
//  ProfileTableViewCell.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/27/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var createdAtText: UILabel!
    @IBOutlet weak var sceenText: UILabel!
    @IBOutlet weak var tweetBodyText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImage.layer.cornerRadius = 5
        self.profileImage.clipsToBounds = true
        self.tweetBodyText.preferredMaxLayoutWidth = self.tweetBodyText.frame.size.width
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setCells(tweet: Tweet){
        self.profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
        self.nameText.text = tweet.user?.name
        self.createdAtText.text = tweet.createdAt?.timeAgoSinceNow()
        self.sceenText.text = "@\(tweet.user!.screenName)"
        self.tweetBodyText.text = tweet.text
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.tweetBodyText.preferredMaxLayoutWidth = self.tweetBodyText.frame.size.width
    }
    
}
