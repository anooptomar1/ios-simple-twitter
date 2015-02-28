//
//  MentionTableViewCell.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/28/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class MentionTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var screenText: UILabel!
    @IBOutlet weak var createdText: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.profileImage.layer.cornerRadius = 5
        self.profileImage.clipsToBounds = true
        
        self.tweetText.preferredMaxLayoutWidth = self.tweetText.frame.size.width
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(tweet: Tweet){
        self.profileImage.setImageWithURL(NSURL(string: (tweet.user!.profileImageUrl)!))
        self.nameText.text = tweet.user?.name
        self.screenText.text = tweet.user?.screenName
        self.createdText.text = tweet.createdAt?.timeAgoSinceNow()
        self.tweetText.text = tweet.text
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tweetText.preferredMaxLayoutWidth = self.tweetText.frame.size.width
    }
    
}
