//
//  MenuViewController.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/25/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

protocol MenuViewControllerDelegate: class{
    func didSelectMenu(menu:String)
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: MenuViewControllerDelegate?
    
    var menuItems: [MenuItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuItems = [MenuItem]()
        var homeMenu = MenuItem(_name: "Me", _icon:  UIImage(named: "birds6")!)
        var timeline = MenuItem(_name: "Timeline", _icon:  UIImage(named: "time39")!)
        var timelineMenu = MenuItem(_name: "Mentions", _icon:  UIImage(named: "user168")!)
        var logoutMenu = MenuItem(_name: "Logout", _icon: UIImage(named: "logout20")!)
        
        menuItems.append(homeMenu)
        menuItems.append(timeline)
        menuItems.append(timelineMenu)
        menuItems.append(logoutMenu)
        
        userImage.setImageWithURL(NSURL(string: User.CurrentUser!.profileImageUrl))
        userImage.layer.cornerRadius = 5
        userImage.clipsToBounds = true
        
        userName.text = User.CurrentUser?.name
        screenName.text = User.CurrentUser?.screenName
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.reloadData()
        tableView.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.delegate?.didSelectMenu(menuItems[indexPath.row].name)
    }
    
    @IBAction func onImageTap(sender: UITapGestureRecognizer) {
        self.delegate?.didSelectMenu("Me")
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell") as MenuTableViewCell
        cell.menuPic.image = menuItems[indexPath.row].icon
        cell.menuLabel.text = menuItems[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
}
