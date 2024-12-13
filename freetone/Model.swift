//
//  Model.swift
//  freetone
//
//  Created by Mac on 23/11/2024.
//

import Foundation

class User {
    var email: String
    var id: String
    var profileImageUrl: String
    
    init(email: String, id: String, profileImageUrl: String) {
        self.email = email
        self.id = id
        self.profileImageUrl = profileImageUrl
    }
}
