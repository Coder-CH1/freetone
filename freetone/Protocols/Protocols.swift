//
//  Protocols.swift
//  freetone
//
//  Created by Mac on 02/12/2024.
//

import UIKit

protocol ProfileTableViewDelegate {
    func didLogout()
}

protocol InboxTableViewDelegate {
    func didSelectMessage(_ message: Message)
}
