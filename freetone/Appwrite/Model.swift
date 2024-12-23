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
    var id: String
    
    //MARK: - Initialize -
    init(senderPhoneNumber: String, recipientPhoneNumber: String, messageBody: String, time: String, id: String) {
        self.senderPhoneNumber = senderPhoneNumber
        self.recipientPhoneNumber = recipientPhoneNumber
        self.messageBody = messageBody
        self.time = time
        self.id = id
    }
    
    //MARK: - Convert user object to a dictionary -
    func toDictionary() -> [String: Any] {
        return [
            "senderPhoneNumber": self.senderPhoneNumber,
            "recipientPhoneNumber": self.recipientPhoneNumber,
            "messageBody": self.messageBody,
            "time": self.time,
            "id": self.id
        ]
    }
}

//MARK: - Data Model -
struct Call {
    var senderPhoneNumber: String
    var recipientPhoneNumber: String
    var time: String
    var id: String
    
    //MARK: - Initialize -
    init(senderPhoneNumber: String, recipientPhoneNumber: String, time: String, id: String) {
        self.senderPhoneNumber = senderPhoneNumber
        self.recipientPhoneNumber = recipientPhoneNumber
        self.time = time
        self.id = id
    }
    
    //MARK: - Convert user object to a dictionary -
    func toDictionary() -> [String: Any] {
        return [
            "senderPhoneNumber": self.senderPhoneNumber,
            "recipientPhoneNumber": self.recipientPhoneNumber,
            "time": self.time,
            "id": self.id
        ]
    }
}
