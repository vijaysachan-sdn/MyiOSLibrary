//
//  FWFirebaseManager.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/24/25.
//
import FirebaseFirestore
public actor FWFirebaseManager{
    public static let shared = FWFirebaseManager()
    private init(){}
    // MARK: Firestore
    private var cacheMode: FirestoreCacheMode = .persistent() // default
    public lazy var firestore:FirestoreManager={
        return FirestoreManager(cacheMode: cacheMode)
    }()
    public func configure(cacheMode: FirestoreCacheMode) {
        self.cacheMode = cacheMode
    }
}
public enum FirestoreCacheMode {
    case persistent(sizeInBytes: Int64 = 100 * 1024 * 1024) // default 100 MB
    case inMemory
}
