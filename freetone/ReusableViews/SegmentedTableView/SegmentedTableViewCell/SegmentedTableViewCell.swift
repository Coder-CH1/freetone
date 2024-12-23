//
//  SegmentedTableViewCell.swift
//  freetone
//
//  Created by Mac on 23/11/2024.
//

import UIKit

class SegmentedTableViewCell: UITableViewCell {
    
    let callLabel = Label(label: "", textColor: UIColor(red: 0/255, green: 255/255, blue: 230/255, alpha: 1.0), font: UIFont.systemFont(ofSize: 16, weight: .regular))
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setSubviewsAndLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setSubviewsAndLayout()
    }
    
    // MARK: - Subviews and Layout -
    func setSubviewsAndLayout() {
        addSubview(callLabel)
        
        NSLayoutConstraint.activate([
            callLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            callLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            callLabel.topAnchor.constraint(equalTo: topAnchor, constant: -20),
        ])
    }
    
    func configure(call: Call) {
        callLabel.text = call.recipientPhoneNumber
    }
}
