//
//  TweetsViewController.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/18/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource, TweetTableViewCellDelegate, DetailsViewControllerDelegate, NewTweetViewControllerDelegate{
    var sTweet: Tweet?
    var tweets = [Tweet]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 177/255, blue: 255/255, alpha: 1.0)
        titleLabel()
        logoutButtonItem()
        newButtonItem()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        
        reloadDataFromTwitter()
        
    }
    
    func reloadDataFromTwitter(){
        TwitterClient.sharedInstance.getHomeTimeline { (tweets) -> () in
            self.tweets = tweets!
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tweets.count > 0){
            return tweets.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetTableViewCell
        var tweet = self.tweets[indexPath.row]
        cell.setTweet(tweet);
        //println(indexPath.row)
        return cell
    }
    
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        super.didRotateFromInterfaceOrientation(fromInterfaceOrientation)
        tableView.reloadData()
    }
    
    func newButtonItem(){
        var newTweetButton = UIBarButtonItem(title: "New", style: UIBarButtonItemStyle.Plain, target: self, action: "onNewTweet")
        newTweetButton.tintColor = UIColor.whiteColor()
        newTweetButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        self.navigationItem.rightBarButtonItem = newTweetButton
    }
    
    func logoutButtonItem(){
        var logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.Plain, target: self, action: "onLogout")
        logoutButton.tintColor = UIColor.whiteColor()
        logoutButton.setTitleTextAttributes([NSFontAttributeName:UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem = logoutButton
    }

    @IBAction func onReply(sender: AnyObject) {
        sTweet = selectedTweet((sender as UIButton).tag)
    }
    
    func titleLabel(){
        var titleLabel = UILabel()
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont(name: "Chalkduster", size: 17)
        self.navigationItem.titleView = titleLabel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onLogout() {
        User.CurrentUser?.Logout()
    }
    
    func didFavoriteChanged(tweetTableViewCell: TweetTableViewCell, tweetValue: Tweet) {
        for tweet in tweets{
            if(tweet.id == tweetValue.id){
                tweet.favorited = tweetValue.favorited
                println("tweet: \(tweetValue.user?.name) fav \(tweetValue.favorited)")
            }
        }
    }
    
    func didTweetObjectChanged(detailsViewController: DetailsViewController, tweet: Tweet) {
        for aTweet in tweets{
            if(aTweet.id == tweet.id){
                aTweet.retweeted = tweet.retweeted
                aTweet.favorited = tweet.favorited
            }
        }
    }
    
    func onNewTweet(){
        var newTweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("newTweetVC") as NewTweetViewController
        newTweetVC.delegate = self
        var nvc = UINavigationController(rootViewController: newTweetVC)
        
        presentViewController(nvc, animated: true, completion: nil)
    }
    
    func didPostNewTweet(newTweetViewController: NewTweetViewController, reload: Bool) {
        if(reload){
            NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval.abs(0.06), target: self, selector: "reloadDataFromTwitter", userInfo: nil, repeats: false)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailsSegue"){
            let details = segue.destinationViewController as DetailsViewController
            var selectedIndexPath = self.tableView.indexPathForSelectedRow()!
            details.tweet = self.tweets[selectedIndexPath.row]
        }else if(segue.identifier == "reply2Segue"){
            let reply = segue.destinationViewController as ReplyViewController
            reply.originalTweet = sTweet!
            reply.sourceVC = segue.sourceViewController as TweetsViewController
        }
    }
    func selectedTweet(replyTag: Int) -> Tweet?{
        for tweet in tweets{
            if(tweet.id == "\(replyTag)"){
                return tweet
            }
        }
        return nil
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
