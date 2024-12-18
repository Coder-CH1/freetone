//
//  MenuTableViewCell.swift
//  freetone
//
//  Created by Mac on 02/12/2024.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    let identifier = "MenuTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        if let textLabel = textLabel {
            textLabel.frame = CGRect(x: textLabel.frame.origin.x + 15, y: textLabel.frame.origin.y, width: textLabel.frame.size.width - 30, height: textLabel.frame.size.height)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if let textLabel = textLabel {
            textLabel.frame = CGRect(x: textLabel.frame.origin.x + 15, y: textLabel.frame.origin.y, width: textLabel.frame.size.width - 30, height: textLabel.frame.size.height)
        }
    }

}
