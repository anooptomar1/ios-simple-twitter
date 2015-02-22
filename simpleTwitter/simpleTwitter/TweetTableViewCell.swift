//
//  TweetTableViewCell.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/19/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol TweetTableViewCellDelegate: class{
    func didFavoriteChanged(tweetTableViewCell: TweetTableViewCell, tweetValue: Tweet)
}

class TweetTableViewCell: UITableViewCell {

    weak var delegate: TweetTableViewCellDelegate?
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var currentTweet: Tweet!
    
    @IBOutlet weak var favoriteBtn: UIButton!
    @IBOutlet weak var retweetedBtn: UIButton!
    @IBOutlet weak var replyBtn: UIButton!
    
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
        self.handleLabel.text = "@\(tweet.user!.screenName)"
        self.createdAtLabel.text = tweet.createdAt?.shortTimeAgoSinceNow()
        self.favoriteBtn.imageView?.image = tweet.favorited ? UIImage(named: "favorite_on") : UIImage(named: "favorite")
        self.retweetedBtn.imageView?.image = tweet.retweeted ? UIImage(named: "retweet_on") : UIImage(named: "retweet")
        replyBtn.tag = tweet.id.integerValue
        currentTweet = tweet
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tweetLabel.preferredMaxLayoutWidth = self.tweetLabel.frame.size.width;
    }

    @IBAction func onFavorite(sender: AnyObject) {
        setFavoriteButton()
        self.delegate?.didFavoriteChanged(self, tweetValue: currentTweet)
    }
    
    func setFavoriteButton(){
        if(currentTweet.favorited){
            TwitterClient.sharedInstance.destroyFavoriteTweet(currentTweet.id, complete: { (success) -> () in
                if(success){
                    self.currentTweet.favorited = false
                    self.favoriteBtn.imageView?.image = UIImage(named: "favorite")
                }
            })
        }else{
            TwitterClient.sharedInstance.favoriteTweet(currentTweet.id, complete: { (success) -> () in
                if(success){
                    self.currentTweet.favorited = true
                    self.favoriteBtn.imageView?.image = UIImage(named: "favorite_on")
                }
            })
        }
    }
}
