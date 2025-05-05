//
//  FirebaseAuthInfo.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 5/5/25.
//
import FirebaseAuth
public class FirebaseAuthInfo{
    public var user:User?
    init(user: User? = nil) {
        self.user = user
    }
}
