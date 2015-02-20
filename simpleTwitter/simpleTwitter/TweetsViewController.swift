//
//  TweetsViewController.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/18/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

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
        
        TwitterClient.sharedInstance.getHomeTimeline { (tweets) -> () in
            self.tweets = tweets!
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.rowHeight = UITableViewAutomaticDimension;
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
        if(tweets.count>0){
            cell.setTweet(self.tweets[indexPath.row]);
        }
        return cell
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

    func titleLabel(){
        var titleLabel = UILabel()
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont(name: "Chalkduster", size: 20)
        self.navigationItem.titleView = titleLabel
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onLogout() {
        User.CurrentUser?.Logout()
    }
    
    func onNewTweet(){
        println("New tweet button")
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
