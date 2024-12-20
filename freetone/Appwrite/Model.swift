//
//  Model.swift
//  freetone
//
//  Created by Mac on 23/11/2024.
//

import Foundation

//MARK: - Data Model -
struct User {
    var email: String
    var id: String
    var phoneNumbers: String
    var profileImageUrl: String
    
    //MARK: - Initialize -
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

//MARK: - Data Model -
struct Message {
    var senderPhoneNumber: String
    var recipientPhoneNumber: String
    var messageBody: String
    var time: String
    
    //MARK: - Initialize -
    init(senderPhoneNumber: String, recipientPhoneNumber: String, messageBody: String, time: String) {
        self.senderPhoneNumber = senderPhoneNumber
        self.recipientPhoneNumber = recipientPhoneNumber
        self.messageBody = messageBody
        self.time = time
    }
    
    //MARK: - Convert user object to a dictionary -
    func toDictionary() -> [String: Any] {
        return [
            "senderPhoneNumber": self.senderPhoneNumber,
            "recipientPhoneNumber": self.recipientPhoneNumber,
            "messageBody": self.messageBody,
            "time": self.time
        ]
    }
}
