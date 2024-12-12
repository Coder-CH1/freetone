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
class AuthManager {
    //MARK: - Singleton design pattern to be shared to the adopted viewcontrollers -
    static let shared = AuthManager()
    
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
    
    var currentUser: User?
    @Published var email = ""
    @Published var password = ""
    @Published var token = ""
    @Published var errorMessage = ""
    @Published var sessionToken: String?
    @Published var isLoggedIn: Bool = false
    
    //MARK: - FETCHING USER -
    func getUser() async {
        do {
            let user = try await account.get()
            await MainActor.run {
                self.email = user.email 
            }
        } catch {
            await MainActor.run {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - PERSIST USER SESSION/LOGIN SESSION -
    func checkStoredSession() async {
        if let token = UserDefaults.standard.string(forKey: "sessionToken") {
            self.sessionToken = token
            await checkSession()
        } else {
            await MainActor.run {
                isLoggedIn = false
            }
        }
    }
    
    //MARK: - CHECK USER SESSION -
    func checkSession() async {
        do {
            let session = try await account.getSession(sessionId: "current")
            await MainActor.run {
                isLoggedIn = true
                self.sessionToken = session.userId
            }
        } catch {
            await MainActor.run {
                self.isLoggedIn = false
                self.errorMessage = "No active session"
            }
        }
    }
    
    //MARK: - REGISTER USER -
    func register() async {
        do {
            _  = try await account.create(
                userId: ID.unique(),
                email: email,
                password: password
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
                email: email,
                password: password
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

