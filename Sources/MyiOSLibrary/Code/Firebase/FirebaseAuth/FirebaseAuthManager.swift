//
//  FirebaseAuthManager.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 5/2/25.
//
import Foundation
import FirebaseAuth
public actor FirebaseAuthManager:FWLoggerDelegate {
    public enum SignInType{
        case anonymous
    }
    public let tag: String=String(describing: FirebaseAuthManager.self)
    
    public func  handleSignIn(signInType:SignInType,closure: @escaping (Result<FirebaseAuthInfo, Error>) -> Void){
        switch signInType{
        case .anonymous:
            SignInAnonymously().signIn(closure: closure)
        }
        //        default:
        //            closure(.failure(FWError(message: "Unsupported SignInType")))
    }
    public func checkIfUserIsLoggedIn()->FirebaseAuthInfo?{
        if let user = Auth.auth().currentUser{
            mLog(msg:"User is logged in")
            return FirebaseAuthInfo(user: user)
        } else {
            mLog(msg:"No user is logged in")
        }
        return nil
    }
}
