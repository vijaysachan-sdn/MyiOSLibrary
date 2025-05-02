//
//  FirebaseAuthManager.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 5/2/25.
//

import Foundation
import FirebaseAuth
public actor FirebaseAuthManager:FWLoggerDelegate {
    public let tag: String=String(describing: FirebaseAuthManager.self)
    public func signInAnonymously(closure: @escaping (Result<User, Error>) -> Void){
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else {
                closure(.failure(error ?? NSError(domain: "", code: 0, userInfo: nil)))
                self.mLog(msg: "Auth failed with error: \(String(describing: error))")
                return
            }
            let isAnonymous = user.isAnonymous  // true
            let uid = user.uid
            self.mLog(msg: "Auth successful for user: isAnonymous: \(isAnonymous), uid:\(user.uid)")
            closure(.success(user))
        }
    }
    public func checkIfUserIsLoggedIn()->User?{
        if let user = Auth.auth().currentUser {
            mLog(msg:"User is logged in")
            return user
        } else {
            mLog(msg:"No user is logged in")
        }
        return nil
    }
}
