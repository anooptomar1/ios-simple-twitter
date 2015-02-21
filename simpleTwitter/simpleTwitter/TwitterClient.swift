//
//  TwitterClient.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/17/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

struct sharedVariables{
    static let twitterConsumerKey = "Rxmj2e91UUgCbajfRLtR2w0k4"
    static let twitterConsumerSecret = "isgb3OZG1bSlm3cd8shsrsMgVBpBin1rr8fL8lzZtt0NZrFpkm"
    static let twitterBaseURL = NSURL(string: "https://api.twitter.com")
}

class TwitterClient: BDBOAuth1RequestOperationManager {
    
    var loginCompletion: ((user: User?) -> ())?
    
    class var sharedInstance: TwitterClient {
        
        struct Static{
            static let instance = TwitterClient(baseURL: sharedVariables.twitterBaseURL, consumerKey: sharedVariables.twitterConsumerKey, consumerSecret: sharedVariables.twitterConsumerSecret);
        }
        
        return Static.instance;
    }
    
    func getHomeTimeline(completion: (tweets: [Tweet]?) -> ()){
        var param = ["count":20]
        TwitterClient.sharedInstance.GET("1.1/statuses/home_timeline.json", parameters: param, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                        //println(response)
            var tweets = Tweet.tweetsFromArray(response as [NSDictionary])
            completion(tweets: tweets)
            
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        })
    }
    
    func favoriteTweet(tweetId: NSString, complete:(success: Bool) -> ()){
        var param = ["id" : tweetId]
        TwitterClient.sharedInstance.POST("1.1/favorites/create.json", parameters: param, constructingBodyWithBlock: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            //println(result["id_str"])
            complete(success: true)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            complete(success: false)
        })
    }
    
    func destroyFavoriteTweet(tweetId: NSString, complete:(success: Bool) -> ()){
        var param = ["id" : tweetId]
        TwitterClient.sharedInstance.POST("1.1/favorites/destroy.json", parameters: param, constructingBodyWithBlock: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            //println(result["id_str"])
            complete(success: true)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                complete(success: false)
        })
    }
    
    func retweet(tweetObj: Tweet, complete: (retweetResp: String) -> ()){
        TwitterClient.sharedInstance.POST("1.1/statuses/retweet/\(tweetObj.id).json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            //tweetObj.retweetId = result["id_str"] as NSString
            complete(retweetResp: result["id_str"] as String)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println(error)
        })
    }
    
    func removeRetweet(retweetId: NSString, complete: (success: Bool) -> ()){
        TwitterClient.sharedInstance.POST("1.1/statuses/destroy/\(retweetId).json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, result: AnyObject!) -> Void in
            //tweetObj.retweetId = result["id_str"] as NSString
            complete(success: true)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
            complete(success: false)
        })
    }
    
    func loginWithCompletion(completion: (user: User?) -> ()){
        
        loginCompletion = completion
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL:
            NSURL(string: "dtasimpletwitter://oauth"), scope: nil, success: { (requestToken: BDBOAuthToken!) -> Void in
            
            var authUrl = NSURL(string: "\(sharedVariables.twitterBaseURL!)/oauth/authorize?oauth_token=\(requestToken.token)")!
            
            UIApplication.sharedApplication().openURL(authUrl)
            }, failure: { (error: NSError!) -> Void in
                println(error);
        })
    }
    
    func openUrl(url: NSURL){
        
        TwitterClient.sharedInstance.fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuthToken(queryString: url.query), success: { (accessToken: BDBOAuthToken!) -> Void in
            //println("got access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                //println(response)
                    var user = User(dictionary: response as NSDictionary)
                    User.CurrentUser = user
                    self.loginCompletion?(user: user)
                    //println(user.name)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println(error)
            })
            }, failure:{ (error: NSError!) -> Void in
                println("got error")
        })
        
        
    }
}
