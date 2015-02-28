//
//  ProfileViewController.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/27/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userBackImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userBackImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.userProfileImage.layer.cornerRadius = 5
        self.userProfileImage.clipsToBounds = true
        self.userBackImage.setImageWithURL(NSURL(string: (User.CurrentUser?.profileBackImage)!))
        self.userProfileImage.setImageWithURL(NSURL(string: (User.CurrentUser?.profileImageUrl)!))
        self.userNameLabel.text = User.CurrentUser!.name
        self.screenNameLabel.text = "@\(User.CurrentUser!.screenName)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
