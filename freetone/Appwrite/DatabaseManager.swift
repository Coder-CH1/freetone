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
    //MARK: - Singleton design pattern -
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
    
    //MARK: - Create document in a Collection -
    func createCollection(user: User) async {
        let collectionId = "users"
        let databaseId = "default"
        
        do {
            let document = try await database.createDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: ID.unique(),
                data: user.toDictionary(),
                permissions: ["read('any')"]
            )
            print("Document created with ID: \(document.id)")
        } catch {
            print("Error creating document \(error.localizedDescription)")
        }
    }
    
    //MARK: - Fetch All documents in a Collection -
    func fetchAllDocuments() async {
        let collectionId = "users"
        let databaseId = "default"
        
        do {
            let documents = try await database.listDocuments(
                databaseId: databaseId,
                collectionId: collectionId,
                queries: []
            )
            for document in documents.documents {
                print("Document in collection fetched successfully: \(document)")
            }
        } catch {
            print("Error fetching documents: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Fetch document by ID -
    func fetchDocumentById(documentId: String) async {
        let collectionId = "users"
        let databaseId = "default"
        
        do {
            let document = try await database.getDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: documentId)
            print("Document fetched successfully: \(document)")
        } catch {
            print("Error fetching document: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Update document by ID -
    func updateDocument(documentId: String, user: User) async {
        let collectionId = "users"
        let databaseId = "default"
        
        do {
            let updatedDocument = try await database.updateDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: documentId,
                data: user.toDictionary()
                //permissions: ["read('any')"]
            )
            print("Document upddated successfully: \(updatedDocument)")
        } catch {
            print("Error updating document: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Delete document by ID -
    func deleteDocument(documentId: String) async {
        let collectionId = "users"
        let databaseId = "default"
        
        do {
            _ = try await database.deleteDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: documentId)
            print("Document deleted successfully with ID: \(documentId)")
        } catch {
            print("Error deleting document: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Save a message document in the 'messages' Collection -
    func saveMessage(message: Message) async {
        let collectionId = "messages"
        let databaseId = "default"
        
        do {
            let document = try await database.createDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: ID.unique(),
                data: message.toDictionary(),
                permissions: ["read('any')"]
            )
            print("Message saved with ID: \(document.id)")
        } catch {
            print("Error saving message \(error.localizedDescription)")
        }
    }
}
