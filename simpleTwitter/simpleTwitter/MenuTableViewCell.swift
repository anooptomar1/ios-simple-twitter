//
//  MenuTableViewCell.swift
//  simpleTwitter
//
//  Created by Anoop tomar on 2/26/15.
//  Copyright (c) 2015 devtechie.com. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet weak var menuPic: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
