//
//  ContainerViewController.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/25/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

enum MenuState{
    case menuOpen
    case menuClosed
}

class ContainerViewController: UIViewController, TweetsViewControllerDelegate, UIGestureRecognizerDelegate, MenuViewControllerDelegate {

    var tweetViewController: TweetsViewController!
    var menuViewController: MenuViewController!
    var navController: UINavigationController!
    
    var currentMenuStatus = MenuState.menuClosed
    
    var sb = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetViewController = sb.instantiateViewControllerWithIdentifier("tweetsVC") as TweetsViewController
        tweetViewController.delegate = self
        
        navController = UINavigationController(rootViewController: tweetViewController)
        
        view.addSubview(navController.view)
        addChildViewController(navController)
        navController.didMoveToParentViewController(self)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        navController.view.addGestureRecognizer(panGesture)
    }

    func handlePanGesture(sender: UIPanGestureRecognizer){
        
        var lTRGesture = sender.velocityInView(view).x > 0
        
        switch(sender.state){
            
        case .Began:
            if(currentMenuStatus == MenuState.menuClosed){
                if(lTRGesture){
                    addMenuBar()
                }
            }
        case .Changed:
            sender.view!.center.x = sender.view!.center.x + sender.translationInView(view).x
            sender.setTranslation(CGPointZero, inView: view)
            
        case .Ended:
            if(menuViewController != nil){
                var movedMoreThanHalf = sender.view!.center.x > view.bounds.size.width
                shouldAnimateOpen(movedMoreThanHalf)
            }else{
                animateMenuBar(0, completion: nil)

            }
        default: break
        }
    
    }
    
    func didSelectMenu(menu: String) {
        if(menu == "Me"){
            var profileVC = sb.instantiateViewControllerWithIdentifier("profileVC") as ProfileViewController
            var profileNavController = UINavigationController(rootViewController: profileVC)
            presentViewController(profileNavController, animated: true, completion: nil)
        }
        shouldAnimateOpen(false)
    }

    func toggleMenu() {
        if(menuViewController == nil){
            addMenuBar()
            shouldAnimateOpen(true)
        }else{
            shouldAnimateOpen(false)
        }
    }
    
    func shouldAnimateOpen(open: Bool){
        if(open){
            animateMenuBar(self.navController.view.frame.width - 80, completion: nil)
        }else{
            animateMenuBar(0, completion: {
                finished in
                self.menuViewController.removeFromParentViewController()
                self.menuViewController.view.removeFromSuperview()
                self.menuViewController = nil
                self.currentMenuStatus = MenuState.menuClosed
            })
        }
    }
    
    func animateMenuBar(moveTo: CGFloat, completion: ((Bool) -> Void)! = nil){
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
            self.navController.view.frame.origin.x = moveTo
            }, completion: completion)
    }
    
    func addMenuBar(){
        menuViewController = sb.instantiateViewControllerWithIdentifier("menuVC") as MenuViewController
        self.view.insertSubview(menuViewController.view, atIndex: 0)
        self.addChildViewController(menuViewController)
        self.didMoveToParentViewController(menuViewController)
        menuViewController.delegate = self
        currentMenuStatus = MenuState.menuOpen
    }
}
