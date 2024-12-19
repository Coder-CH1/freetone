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
    var phoneNumbers: String
    var profileImageUrl: String
    
    init(email: String, id: String,phoneNumbers: String, profileImageUrl: String) {
        self.email = email
        self.id = id
        self.phoneNumbers = phoneNumbers
        self.profileImageUrl = profileImageUrl
    }
    
    //MARK: - Convert user object to a dictionary -
    func toDictionary() -> [String: Any] {
        return [
            "email": self.email,
            "id": self.id,
            "phoneNumbers": self.phoneNumbers,
            "profileImageUrl": self.profileImageUrl
        ]
    }
}
