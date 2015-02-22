//
//  DetailsViewController.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/20/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol DetailsViewControllerDelegate: class{
    func didTweetObjectChanged(detailsViewController: DetailsViewController, tweet: Tweet)
}

class DetailsViewController: UIViewController {

    // delegate
    weak var delegate: DetailsViewControllerDelegate?
    
    // handles
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var sceenNameLbl: UILabel!
    @IBOutlet weak var retweetCountLbl: UILabel!
    @IBOutlet weak var favoriteCountLbl: UILabel!
    @IBOutlet weak var retweetByLbl: UILabel!
    @IBOutlet weak var tweetLbl: UILabel!
    @IBOutlet weak var createdAtLbl: UILabel!
    @IBOutlet weak var retweetBtn: UIButton!
    @IBOutlet weak var favoriteBtn: UIButton!
    
    //
    
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 177/255, blue: 255/255, alpha: 1.0)
        titleLabel()
        addLeftButton()
        addRightButton()
        populateView()
    }

    func populateView(){
        self.profileImage.setImageWithURL(NSURL(string: (tweet?.user?.profileImageUrl)!))
        self.profileImage.layer.cornerRadius = 5
        self.profileImage.clipsToBounds = true
        self.userNameLbl.text = tweet?.user?.name
        self.sceenNameLbl.text = tweet?.user?.screenName
        let rtCount:Int = (tweet?.retweetCount)!
        self.retweetCountLbl.text = "\(rtCount)"
        let fvCount:Int = (tweet?.favoriteCount)!
        self.favoriteCountLbl.text = "\(fvCount)"
        self.tweetLbl.text = tweet?.text
        self.createdAtLbl.text = tweet?.createdAt?.formattedDateWithFormat("MM/dd/yyyy HH:mm a")
        setRetweetImage()
        setFavoriteImage()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setRetweetImage(){
        if(tweet!.retweeted){
            self.retweetImage.image = UIImage(named: "retweet_on")
            retweetBtn.imageView!.image = UIImage(named: "retweet_on")
            retweetBtn.setImage(UIImage(named: "retweet_on"), forState: UIControlState.Normal)
        }
        else{
            retweetBtn.imageView!.image = UIImage(named: "retweet")
            retweetBtn.setImage(UIImage(named: "retweet"), forState: UIControlState.Normal)
            self.retweetImage.image = UIImage(named: "retweet")
        }
    }
    
    func setFavoriteImage(){
        if(tweet!.favorited){
            favoriteBtn.setImage(UIImage(named: "favorite_on"), forState: UIControlState.Normal)
        }else{
            favoriteBtn.setImage(UIImage(named: "favorite"), forState: UIControlState.Normal)
        }
    }
    
    func addLeftButton(){
        var backButton = UIBarButtonItem(title: "< Home", style: UIBarButtonItemStyle.Plain, target: self, action: "onBackButton")
        backButton.tintColor = UIColor.whiteColor()
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func addRightButton(){
        var replyButton = UIBarButtonItem(title: "Reply", style: UIBarButtonItemStyle.Plain, target: self, action: "onReplyButton")
        replyButton.tintColor = UIColor.whiteColor()
        replyButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        
        self.navigationItem.rightBarButtonItem = replyButton
    }
    
    func onReplyButton(){
        self.performSegueWithIdentifier("replySegue", sender: self)
    }
    
    func onBackButton(){
        self.delegate?.didTweetObjectChanged(self, tweet: tweet!)
        self.navigationController?.popToRootViewControllerAnimated(true)
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onFavorite(sender: AnyObject) {
        setFavoriteButton()
    }
    @IBAction func onRetweet(sender: AnyObject) {
        if(tweet?.retweetId == ""){
            TwitterClient.sharedInstance.retweet(tweet!, complete: { (retweetResp) -> () in
                self.updateRetweetId(retweetResp)
            })
        }else{
            TwitterClient.sharedInstance.removeRetweet(tweet!.retweetId, complete: { (success) -> () in
                self.removeRetweet()
            })
        }
    }
    
    func updateRetweetId(newRetweetId: String){
        tweet?.retweetId = newRetweetId
        retweetBtn.imageView!.image = UIImage(named: "retweet_on")
        tweet?.retweeted = true
    }
    
    func removeRetweet(){
        tweet?.retweetId = ""
        retweetBtn.imageView!.image = UIImage(named: "retweet")
        tweet?.retweeted = false
    }
    
    func titleLabel(){
        var titleLabel = UILabel()
        titleLabel.text = "Tweet"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont(name: "Chalkduster", size: 17)
        self.navigationItem.titleView = titleLabel
    }
    
    func setFavoriteButton(){
        if(tweet?.favorited == true){
            TwitterClient.sharedInstance.destroyFavoriteTweet(tweet!.id, complete: { (success) -> () in
                if(success){
                    self.tweet?.favorited = false
                    self.favoriteBtn.imageView?.image = UIImage(named: "favorite")
                }
            })
        }else{
            TwitterClient.sharedInstance.favoriteTweet(tweet!.id, complete: { (success) -> () in
                if(success){
                    self.tweet?.favorited = true
                    self.favoriteBtn.imageView?.image = UIImage(named: "favorite_on")
                }
            })
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "replySegue"){
            let replyVC = segue.destinationViewController as ReplyViewController
            replyVC.originalTweet = tweet!
            replyVC.sourceVC = segue.sourceViewController as DetailsViewController
        }
    }
    
}
