//
//  SignInAnonymously.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 5/5/25.
//
import Foundation
import FirebaseAuth
class SignInAnonymously:FWLoggerDelegate{
    let tag:String=String(describing: SignInAnonymously.self)    
     func signIn(closure: @escaping (Result<FirebaseAuthInfo, Error>) -> Void){
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else {
                closure(.failure(error ?? NSError(domain: "", code: 0, userInfo: nil)))
                self.mLog(msg: "Auth failed with error: \(String(describing: error))")
                return
            }
            let isAnonymous = user.isAnonymous  // true
            //            let uid = user.uid
            self.mLog(msg: "Auth successful for user: isAnonymous: \(isAnonymous), uid:\(user.uid)")
            closure(.success(FirebaseAuthInfo(user: user)))
        }
    }
}
