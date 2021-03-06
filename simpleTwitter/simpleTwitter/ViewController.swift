//
//  ViewController.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/17/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning() 
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion(){
            (user: User?) in
            if(user != nil){
                var containerViewController = self.storyboard?.instantiateViewControllerWithIdentifier("containerVC") as ContainerViewController
                //var tweetVC = self.storyboard?.instantiateViewControllerWithIdentifier("tweetsVC") as TweetsViewController
                self.presentViewController(containerViewController, animated: true, completion: nil)
                //self.performSegueWithIdentifier("loginSegue", sender: self)
            }else{
                // show error
            }
        }
    }
}

