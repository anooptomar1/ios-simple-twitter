//
//  NewTweetViewController.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/21/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol NewTweetViewControllerDelegate: class{
    func didPostNewTweet(newTweetViewController: NewTweetViewController, reload: Bool)
}

class NewTweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var screenNameLbl: UILabel!
    @IBOutlet weak var newTweetText: UITextView!
    
    weak var delegate: NewTweetViewControllerDelegate?
    
    var countLabel: UIBarButtonItem!
    var charCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 40/255, green: 177/255, blue: 255/255, alpha: 1.0)
        titleLabel()
        addLeftButton()
        addRightButton()
        self.profileImage.setImageWithURL(NSURL(string: (User.CurrentUser?.profileImageUrl)!))
        self.profileImage.layer.cornerRadius = 5
        self.profileImage.clipsToBounds = true
        self.userNameLbl.text = User.CurrentUser?.name
        self.screenNameLbl.text = User.CurrentUser?.screenName
        self.newTweetText.delegate = self
        var chars = countChars(self.newTweetText.text)
        countLabel.title = "\(chars)"
    }
    
    func textViewDidChange(textView: UITextView) {
        var chars = countChars(textView.text)
        countLabel.title = "\(chars)"
    }
    
    func addRightButton(){
        var newTweetButton = UIBarButtonItem(title: "Tweet", style: UIBarButtonItemStyle.Plain, target: self, action: "onNewTweet")
        newTweetButton.tintColor = UIColor.whiteColor()
        newTweetButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        
        countLabel = UIBarButtonItem(title: "12", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        countLabel.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        
        self.navigationItem.rightBarButtonItems = [newTweetButton, countLabel]
    }
    
    func addLeftButton(){
        var backButton = UIBarButtonItem(title: "< Home", style: UIBarButtonItemStyle.Plain, target: self, action: "onBackButton")
        backButton.tintColor = UIColor.whiteColor()
        backButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 12)!], forState: UIControlState.Normal)
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func countChars(text: String) -> Int{
        charCount = countElements(text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)
        return charCount
    }
    
    func onNewTweet(){
        if(charCount <= 140){
            var newTweetMessage = self.newTweetText.text.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
            TwitterClient.sharedInstance.replyToTweet("none", text: newTweetMessage)
            
            onBackButton()
            self.delegate?.didPostNewTweet(self, reload: true)
        }else{
            var alert = UIAlertController(title: "Reply should be less than 140 chars", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            
            var okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(okButton)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func onBackButton(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func titleLabel(){
        var titleLabel = UILabel()
        titleLabel.text = "New Tweet"
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
