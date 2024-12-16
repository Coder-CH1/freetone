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
    //MARK: - Singleton design pattern -
    static let shared = AuthManager()
    
    private init() {}
    
    //MARK: - Retrieve project id values from info.plist -
    var projectID: String {
        guard let id = Bundle.main.object(forInfoDictionaryKey: "APPWRITE_PROJECT_ID") as? String else {
            fatalError("")
        }
        return id
    }
    
    //MARK: - Retrieve endpoint values from info.plist -
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
    
    var currentUser: User?
    @Published var email = ""
    @Published var password = ""
    @Published var token = ""
    @Published var errorMessage = ""
    @Published var sessionToken: String?
    @Published var isLoggedIn: Bool = false
    
    //MARK: - FETCHING USER INFO -
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
            await MainActor.run {
                isLoggedIn = true
                self.sessionToken = session.userId
                self.errorMessage = "Logged in successfully: \(session.userId)"
            }            
            UserDefaults.standard.set(session.userId, forKey: "sessionToken")
        } catch {
            await MainActor.run {
                isLoggedIn = false
                self.errorMessage = "Login failed: \(error.localizedDescription)"
            }
        }
    }
    
    //MARK: - LOGING USER OUT -
    func logout() async {
        do {
            _  = try await account.deleteSession(sessionId: "current")
            UserDefaults.standard.removeObject(forKey: "sessionToken")
            await MainActor.run {
                self.currentUser = nil
                self.isLoggedIn = false
                self.email = ""
            }
        } catch {
            await MainActor.run {
                 print(error.localizedDescription)
            }
        }
    }
}

