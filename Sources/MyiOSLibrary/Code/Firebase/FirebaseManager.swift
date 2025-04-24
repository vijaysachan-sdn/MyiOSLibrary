//
//  FirebaseManager.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/24/25.
//

import FirebaseFirestore
public actor FirebaseManager{
    public static let shared = FirebaseManager()
    public lazy var firestore:FirestoreManager={
        return FirestoreManager()
    }()
    private init(){
        
    }
}
