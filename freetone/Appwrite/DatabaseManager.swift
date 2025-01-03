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
    
    //MARK: - Retrieve database id values from info.plist -
    var databaseID: String {
        guard let databaseId = Bundle.main.object(forInfoDictionaryKey: "AppwriteDatabaseID") as? String else {
            fatalError("")
        }
        return databaseId
    }
    
    //MARK: - Retrieve collection id values from info.plist -
    var usersID: String {
        guard let usersId = Bundle.main.object(forInfoDictionaryKey: "AppwriteUsersID") as? String else {
            fatalError("")
        }
        return usersId
    }
    
    //MARK: - Retrieve collection id values from info.plist -
    var messagesID: String {
        guard let messagesId = Bundle.main.object(forInfoDictionaryKey: "AppwriteMessagesID") as? String else {
            fatalError("")
        }
        return messagesId
    }
    
    //MARK: - Retrieve collection id values from info.plist -
    var callsID: String {
        guard let callsId = Bundle.main.object(forInfoDictionaryKey: "AppwriteCallsID") as? String else {
            fatalError("")
        }
        return callsId
    }
    
    //MARK: - Create document in a Collection -
    func createCollection(user: User) async {
        let collectionId = usersID
        let databaseId = databaseID
        
        do {
            let document = try await database.createDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: ID.unique(),
                data: user.toDictionary(),
                permissions: [
                    Permission.read(Role.any())
                ]
            )
            print("Document created with ID: \(document.id)")
        } catch {
            print("Error creating document \(error.localizedDescription)")
        }
    }
    
    //MARK: - Fetch All documents in a Collection -
    func fetchAllDocuments() async {
        let collectionId = usersID
        let databaseId = databaseID
        
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
        let collectionId = usersID
        let databaseId = databaseID
        
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
        let collectionId = usersID
        let databaseId = databaseID
        
        do {
            let updatedDocument = try await database.updateDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: documentId,
                data: user.toDictionary(),
                permissions: [
                    Permission.update(Role.any())
                ]
            )
            print("Document upddated successfully: \(updatedDocument)")
        } catch {
            print("Error updating document: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Delete document by ID -
    func deleteDocument(message: Message) async {
        let collectionId = messagesID
        let databaseId = databaseID
        
        do {
            _ = try await database.deleteDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: message.id)
            print("Document deleted successfully with ID: \(message)")
        } catch {
            print("Error deleting document: \(error.localizedDescription)")
        }
    }
    
    //MARK: - Save a message document in the 'messages' Collection -
    func saveMessage(message: Message) async -> Message? {
        let collectionId = messagesID
        let databaseId = databaseID
        
        do {
            let document = try await database.createDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: ID.unique(),
                data: message.toDictionary(),
                permissions: [
                    Permission.read(Role.any())
                ]
            )
            print("Message saved with ID: \(document.id)")
            var savedMessage = message
            savedMessage.id = document.id
            return savedMessage
        } catch {
            print("Error saving message \(error.localizedDescription)")
            return nil
        }
    }
    
    //MARK: - Fetch a message document in the 'messages' Collection -
    func fetchMessages() async -> [Message]? {
        let collectionId = messagesID
        let databaseId = databaseID
        
        do {
            let documents = try await database.listDocuments(
                databaseId: databaseId,
                collectionId: collectionId,
                queries: []
            )
            var messages: [Message] = []
            for document in documents.documents {
                if let senderPhoneNumber = document.data["senderPhoneNumber"]?.value as? String,
                   let messageBody = document.data["messageBody"]?.value as? String,
                   let recipientPhoneNumber = document.data["recipientPhoneNumber"]?.value as? String,
                   let time = document.data["time"]?.value as? String,
                   let id = document.data["id"]?.value as? String {
                   let message = Message(senderPhoneNumber: senderPhoneNumber, recipientPhoneNumber: recipientPhoneNumber, messageBody: messageBody, time: time, id: id)
                    messages.append(message)
                }
            }
            return messages
        } catch {
            print("error fetching messages \(error.localizedDescription)")
            return nil
        }
    }
    
    //MARK: - Save a call document in the 'calls' Collection -
    func saveCall(call: Call) async -> Call? {
        let collectionId = callsID
        let databaseId = databaseID
        
        do {
            let document = try await database.createDocument(
                databaseId: databaseId,
                collectionId: collectionId,
                documentId: ID.unique(),
                data: call.toDictionary(),
                permissions: [
                    Permission.read(Role.any())
                ]
            )
            print("Message saved with ID: \(document.id)")
            var savedMessage = call
            savedMessage.id = document.id
            return savedMessage
        } catch {
            print("Error saving message \(error.localizedDescription)")
            return nil
        }
    }
    
    //MARK: - Fetch a call document in the 'calls' Collection -
    func fetchCalls() async -> [Call]? {
        let collectionId = callsID
        let databaseId = databaseID
        
        do {
            let documents = try await database.listDocuments(
                databaseId: databaseId,
                collectionId: collectionId,
                queries: []
            )
            var messages: [Call] = []
            for document in documents.documents {
                if let senderPhoneNumber = document.data["senderPhoneNumber"]?.value as? String,
                   let recipientPhoneNumber = document.data["recipientPhoneNumber"]?.value as? String,
                   let time = document.data["time"]?.value as? String,
                   let id = document.data["id"]?.value as? String {
                   let message = Call(senderPhoneNumber: senderPhoneNumber, recipientPhoneNumber: recipientPhoneNumber, time: time, id: id)
                    messages.append(message)
                }
            }
            return messages
        } catch {
            print("error fetching messages \(error.localizedDescription)")
            return nil
        }
    }
}
