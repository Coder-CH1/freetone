//
//  DatabaseManager.swift
//  freetone
//
//  Created by Mac on 02/12/2024.
//

import Foundation
import Appwrite
import NIO
import UIKit

class DatabaseManager {
    //MARK: - Singleton design pattern to be shared to the adopted viewcontrollers -
    static let shared = DatabaseManager()
    
    private init() {}
    
    //MARK: - Retrieve values from info.plist -
    var projectID: String {
        guard let id = Bundle.main.object(forInfoDictionaryKey: "APPWRITE_PROJECT_ID") as? String else {
            fatalError("")
        }
        return id
    }
    
    //MARK: - Retrieve values from info.plist -
    var endPoint: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "APPWRITE_ENDPOINT") as? String else {
            fatalError("")
        }
        return url
    }
    
    //MARK: - Lazy initialization of client -
    lazy var client: Client = {
        let client = Client()
            .setEndpoint(endPoint)
            .setProject(projectID)
        return client
    }()

    //MARK: - Lazy initialization of account -
    lazy var account: Account = {
        let account = Account(client)
        return account
    }()
    
    func createCollection() async {
        
    }
    
    func fetchUser() async {
        
    }
}
