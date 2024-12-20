//
//  InboxTableViewCell.swift
//  freetone
//
//  Created by Mac on 23/11/2024.
//

import UIKit

class InboxTableViewCell: UITableViewCell {
    //MARK: - Object -
    let phoneLabel = Label(label: "", textColor: .blue, font: UIFont.systemFont(ofSize: 16, weight: .regular))
    
    let messageLabel = Label(label: "", textColor: .blue, font: UIFont.systemFont(ofSize: 16, weight: .regular))
    
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
        addSubview(phoneLabel)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            phoneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            phoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
           
            messageLabel.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 5),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func configure(with message: Message) {
        phoneLabel.text = message.senderPhoneNumber
        messageLabel.text = message.messageBody
    }
}
