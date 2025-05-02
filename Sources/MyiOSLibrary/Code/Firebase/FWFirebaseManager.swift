//
//  FWFirebaseManager.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/24/25.
//
import FirebaseFirestore
public actor FWFirebaseManager:FWLoggerDelegate{
    nonisolated
    public var tag: String{
        String(describing: FWFirebaseManager.self)
    }
    public static let shared = FWFirebaseManager()
    private init(){}
    // MARK: Firestore
    private var cacheMode: FirestoreCacheMode = .persistent() // default
    private var countFirestore=0
    public lazy var firestore:FirestoreManager={
        countFirestore+=1
        mLog(msg: "Initializing FirestoreManager \(countFirestore) times")
        return FirestoreManager(cacheMode: cacheMode)
    }()
    public lazy var realtimeDatabase:RealtimeDatabaseManager={
        return RealtimeDatabaseManager()
    }()
    public func configure(cacheMode: FirestoreCacheMode) {
        self.cacheMode = cacheMode
    }
}
public enum FirestoreCacheMode:@unchecked Sendable{
    case persistent(sizeInBytes: Int64 = 100 * 1024 * 1024) // default 100 MB
    case inMemory
}
