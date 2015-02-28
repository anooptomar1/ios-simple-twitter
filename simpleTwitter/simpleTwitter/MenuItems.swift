//
//  MenuItems.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/26/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class MenuItem{
    var icon: UIImage!
    var name: String!
    
    init(_name: String, _icon: UIImage){
        self.name = _name
        self.icon = _icon
    }
}