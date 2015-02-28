//
//  ProfileViewController.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/27/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userBackImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var pageCtrl: UIPageControl!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var followerText: UILabel!
    @IBOutlet weak var followingText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavbar()
        
        self.userBackImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.userProfileImage.layer.cornerRadius = 5
        self.userProfileImage.clipsToBounds = true
        self.userBackImage.setImageWithURL(NSURL(string: (User.CurrentUser?.profileBackImage)!))
        self.userProfileImage.setImageWithURL(NSURL(string: (User.CurrentUser?.profileImageUrl)!))
        self.userNameLabel.text = User.CurrentUser!.name
        self.screenNameLabel.text = "@\(User.CurrentUser!.screenName)"
        self.tweetText.text = "\(User.CurrentUser!.tweetCount)"
        self.followerText.text = "\(User.CurrentUser!.followerCount)"
        self.followingText.text = "\(User.CurrentUser!.followingCount)"
        
        TwitterClient.sharedInstance.homeTimeline { (tweets) -> () in
            self.tweets = tweets!
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 110
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func setupNavbar(){
         self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 177/255, blue: 255/255, alpha: 1.0)
        setLeftBarButton()
    }
    
    func setLeftBarButton(){
        var cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "onCancel")
        cancelButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        cancelButton.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    func onCancel(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("profileCell") as ProfileTableViewCell
        cell.setCells(tweets[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
   
    @IBAction func OnPanGesture(sender: UIPanGestureRecognizer) {
        var lTR = sender.velocityInView(view).x > 0
        if(lTR){
            pageCtrl.currentPage = 1
            self.userNameLabel.text = "\(User.CurrentUser!.name) : Page 2"
            self.screenNameLabel.text = "@\(User.CurrentUser!.screenName)"

        }else{
            pageCtrl.currentPage = 0
            self.userNameLabel.text = "\(User.CurrentUser!.name)"
            self.screenNameLabel.text = "@\(User.CurrentUser!.screenName)"
        }
    }
   
}
