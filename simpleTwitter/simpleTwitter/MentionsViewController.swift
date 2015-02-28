//
//  MentionsViewController.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/28/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        TwitterClient.sharedInstance.mentionsTimeline { (tweets) -> () in
            self.tweets = tweets!
            self.tableView.reloadData()
        }
        setupNavbar()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("mentionCell") as MentionTableViewCell
        cell.setCell(tweets[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
}
