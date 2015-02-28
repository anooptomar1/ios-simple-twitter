//
//  User.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/17/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

var _currentUser: User?
let kCurrentUserKey = "kCurrentUser"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String
    var screenName: String
    var profileImageUrl: String!
    var tagLine: String
    var dictionary: NSDictionary
    var profileBackImage: String
    var followingCount: Int
    var followerCount: Int
    var tweetCount: Int
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary;
        self.name = dictionary["name"] as NSString;
        self.screenName = dictionary["screen_name"] as NSString;
        self.profileImageUrl = dictionary["profile_image_url"] as NSString;
        self.tagLine = dictionary["description"] as NSString;
        self.profileBackImage = dictionary["profile_background_image_url"] as NSString
        self.followingCount = dictionary["friends_count"] as Int
        self.followerCount = dictionary["followers_count"] as Int
        self.tweetCount = dictionary["statuses_count"] as Int
        //println(dictionary)
    }
    
    func Logout(){
        User.CurrentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var CurrentUser: User?{
        get{
        
            if(_currentUser == nil){
                var data = NSUserDefaults.standardUserDefaults().objectForKey(kCurrentUserKey) as? NSData
                if(data != nil){
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
        
        return _currentUser
        
        }set(user){
            _currentUser = user
            
            if(_currentUser != nil){
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: kCurrentUserKey)
            }else{
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: kCurrentUserKey)
            }
            
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
