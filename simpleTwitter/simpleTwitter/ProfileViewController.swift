//
//  ProfileViewController.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/27/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userBackImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userBackImage.contentMode = UIViewContentMode.ScaleAspectFill
        self.userProfileImage.layer.cornerRadius = 5
        self.userProfileImage.clipsToBounds = true
        self.userBackImage.setImageWithURL(NSURL(string: (User.CurrentUser?.profileBackImage)!))
        self.userProfileImage.setImageWithURL(NSURL(string: (User.CurrentUser?.profileImageUrl)!))
        self.userNameLabel.text = User.CurrentUser?.name
        self.screenNameLabel.text = "@\(User.CurrentUser?.screenName)"
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
