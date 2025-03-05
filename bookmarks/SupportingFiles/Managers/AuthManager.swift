//
//  AuthManager.swift
//  bookmarks
//
//  Created by Arturo Olvera Paulino on 03/03/25.
//

import FirebaseAuth
import Combine
import GoogleSignIn
import FirebaseCore

enum AuthStatus {
    case userLogged
    case badCredentials
    case userNotVerified
}

struct AuthManager {
    func signInWithGoogle() -> Future<AuthStatus, Never>  {
        return Future { promise in
            Task {
                guard let rootController = await UIApplication.shared.windows.first?.rootViewController else {
                    promise(.success(.badCredentials))
                    return
                }
                guard let clientId = FirebaseApp.app()?.options.clientID else {
                    promise(.success(.badCredentials))
                    return
                }
                let configuration = GIDConfiguration(clientID: clientId)
                
                GIDSignIn.sharedInstance.configuration = configuration
                do {
                    let result = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootController)
                    
                    guard let tokenId = result.user.idToken?.tokenString else {
                        promise(.success(.badCredentials))
                        return
                    }
                    let accessToken = result.user.accessToken.tokenString
                    let credential = GoogleAuthProvider.credential(withIDToken: tokenId, accessToken: accessToken)
                    
                    if let profile = result.user.profile {
                        InMemory.shared.email = profile.email
                    }
                    try await Auth.auth().signIn(with: credential)
                    
                    let statusResult = await loginWithCredential(authCredential: credential)
                    promise(.success(statusResult))
                } catch {
                    promise(.success(.badCredentials))
                }
                
            }
        }
        
        

        
        
    }
    
    func isLogged() -> Bool {
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            let email = currentUser.email
            let inMemoryData = InMemory.shared

            inMemoryData.email = email
            return true
        } else {
            print("No user is signed in.")
            return false
        }
        
    }
    
    func loggout() -> Bool{
        do {
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
    
    func withCredentials(email: String, password: String) -> Future<AuthStatus, Never> {
        return Future { promise in
            Task {
                let result = await createUser(email: email, password: password)
                promise(.success(result))
            }
        }
    }
    
    
    func createUser(email: String, password: String) async -> AuthStatus {
        do{
            _ = try await Auth.auth().createUser(withEmail: email, password: password)
            
            try await Auth.auth().currentUser?.sendEmailVerification()
            return AuthStatus.userNotVerified
        }
        catch {
            if(error.localizedDescription.contains("already in use")) {
                return await loginUser(email: email, password: password)
            } else {
                print(error.localizedDescription)
                return AuthStatus.badCredentials
            }
        }
        
    }
    
    func loginWithCredential(authCredential: AuthCredential) async -> AuthStatus {
        do {
            _ = try await Auth.auth().signIn(with: authCredential)
            
            if let currentUser = Auth.auth().currentUser {
                return AuthStatus.userLogged
            }
            else {
                return AuthStatus.badCredentials
            }
            
        } catch {
            print("You have entered an incorrect email or password. Please enter the correct email and password.")
            return AuthStatus.badCredentials
        }
    }
    
    func loginUser(email: String, password: String) async -> AuthStatus {
        
        do {
            _ = try await Auth.auth().signIn(withEmail: email, password: password)
            
            if(Auth.auth().currentUser!.isEmailVerified) {
                print("Login Successfully")
                return AuthStatus.userLogged
            }
            else {
                print("Your email is pending verification, Please check your emails for a verification link.")
                return AuthStatus.userNotVerified
            }
            
        } catch {
            print("You have entered an incorrect email or password. Please enter the correct email and password.")
            return AuthStatus.badCredentials
        }
        
    }
}
