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
    
    //MARK: - Lazy initialization of client -
    lazy var client: Client = {
        let client = Client()
            .setEndpoint(AuthManager.shared.endPoint)
            .setProject(AuthManager.shared.projectID)
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
