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
    lazy var database: Databases = {
        let database = Databases(client)
        return database
    }()
    
    func createCollection(user: User) async {
        let collectionId = "users"
        let databaseId = "default"
        do {
        let document = try await database.createDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: ID.unique(),
                data: user.toDictionary())
            print("Document created with ID: \(document.id)")
        } catch {
            print("Error creating document \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async {
        
    }
}
