//
//  ReplyViewController.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/21/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class ReplyViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var useNameLbl: UILabel!
    @IBOutlet weak var screenNameLbl: UILabel!
    @IBOutlet weak var createdAtLbl: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var replyText: UITextView!
   
    var originalTweet: Tweet!
    var sourceVC: UIViewController!
    var charCount: Int = 0
    
    var charCountButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 177/255, blue: 255/255, alpha: 1.0)
        titleLabel()
        addLeftButton()
        addRightButtons()
        populateView()
        replyText.delegate = self
        // Do any additional setup after loading the view.
    }

    func populateView(){
        let scName = (originalTweet.user?.screenName)!
        self.profileImage.setImageWithURL(NSURL(string: (originalTweet.user?.profileImageUrl)!))
        self.profileImage.layer.cornerRadius = 5
        self.profileImage.clipsToBounds = true
        
        self.useNameLbl.text = originalTweet.user?.name
        self.screenNameLbl.text = "@\(scName)"
        self.createdAtLbl.text = originalTweet.createdAt?.shortTimeAgoSinceNow()
        self.tweetText.text = originalTweet.text
        self.replyText.text = "@\(scName) "
        var chars = countChars(self.replyText.text)
        charCountButton.title = "\(chars)"
    }
    
    func textViewDidChange(textView: UITextView) {
        var chars = countChars(textView.text)
        charCountButton.title = "\(chars)"
    }
    
    func countChars(text: String) -> Int{
        charCount = countElements(text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        return charCount
    }
    
    func addRightButtons(){
        var tweetButton = UIBarButtonItem(title: "Reply", style: UIBarButtonItemStyle.Plain, target: self, action: "onReplyButton")
        tweetButton.tintColor = UIColor.whiteColor()
        tweetButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        charCountButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        charCountButton.tintColor = UIColor.whiteColor()
        charCountButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        
        self.navigationItem.rightBarButtonItems = [tweetButton, charCountButton]
    }
    
    func onReplyButton(){
        if(charCount <= 140){
            var replyMessage = self.replyText.text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            TwitterClient.sharedInstance.replyToTweet(originalTweet.id, text: replyMessage)
            onBackButton()
        }else{
            var alert = UIAlertController(title: "Reply should be less than 140 chars", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            
            var okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(okButton)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func addLeftButton(){
        var backButton = UIBarButtonItem(title: "< Tweet", style: UIBarButtonItemStyle.Plain, target: self, action: "onBackButton")
        backButton.tintColor = UIColor.whiteColor()
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func onBackButton(){
        self.navigationController?.popToViewController(sourceVC, animated: true)
    }
    
    func titleLabel(){
        var titleLabel = UILabel()
        let scName = (originalTweet.user?.screenName)!
        titleLabel.text = "Reply \(scName)"
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.font = UIFont(name: "Chalkduster", size: 17)
        self.navigationItem.titleView = titleLabel
    }

}
