//
//  NetworkManager.swift
//  freetone
//
//  Created by Mac on 23/11/2024.
//

import Foundation
import Appwrite
import NIO
import UIKit
//MARK: -
class NetworkManager {
    //MARK: - Singleton design pattern to be shared to the adopted viewcontrollers -
    static let shared = NetworkManager()
    
    private init() {}
    
    //MARK: -
    let client = Client()
        .setEndpoint("https://cloud.appwrite.io/v1")
        .setProject("6746f883000a071f1c3f") 

    //MARK: -
    lazy var account: Account = {
        let account = Account(client)
        return account
    }()
    
    //MARK: - FETCHING USER -
    func getUser() async {
        do {
            let user = try await account.get()
        } catch {
            await MainActor.run {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - PERSIST USER SESSION/LOGIN SESSION -
    func checkStoredSession() async {
        
    }
    
    //MARK: - CHECK USER SESSION -
    func checkSession() async {
       
    }
    
    //MARK: - REGISTER USER -
    func register() async {
        do {
            _  = try await account.create(
                userId: ID.unique(),
                email: "",
                password: ""
            )
        } catch {
            await MainActor.run {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - LOGIN USER -
    func login() async {
        do {
            let session = try await account.createEmailPasswordSession(
                email: "",
                password: ""
            )
        } catch {
            await MainActor.run {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - LOGING USER OUT -
    func logout() async {
        do {
            _  = try await account.deleteSession(sessionId: "current")
            UserDefaults.standard.removeObject(forKey: "sessionToken")
        } catch {
            await MainActor.run {
                 print(error.localizedDescription)
            }
        }
    }
}

