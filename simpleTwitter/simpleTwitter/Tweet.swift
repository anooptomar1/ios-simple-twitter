//
//  Tweet.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/17/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var user: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var retweetCount: Int?
    var favoriteCount: Int?
    
    init(dictionary: NSDictionary){
        self.user = User(dictionary: dictionary["user"] as NSDictionary);
        self.text = dictionary["text"] as NSString
        self.createdAtString = dictionary["created_at"] as NSString
        self.retweetCount = dictionary["retweet_count"] as? Int
        self.favoriteCount = dictionary["favorite_count"] as? Int
        
        var formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!)
        //println(dictionary)
    }
    
    class func tweetsFromArray(array: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        
        for dictionary in array{
            tweets.append(Tweet(dictionary: dictionary));
        }
        
        return tweets;
    }
}
