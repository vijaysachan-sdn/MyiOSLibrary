//
//  FireStoreSnapshotListener.swift
//  MAPS
//
//  Created by Vijay Sachan on 4/23/25.
//
import Foundation
import FirebaseFirestore
public protocol FireStoreSnapshotListener:AnyObject {
    associatedtype Model: Codable
    var listener: ListenerRegistration? { get set }
}
public protocol FireStoreCollectionSnapshotListener:FireStoreSnapshotListener{
    func getRequestData(db:Firestore)->(pathToCollection: String, query: Query)
    /// Called on collection changes
    func onUpdate(data: Result<[Model], Error>, snapshots: [QueryDocumentSnapshot]?)
    
}
public protocol FireStoreDocumentSnapshotListener:FireStoreSnapshotListener{
    var pathToDocument: String { get }
    /// Called on single document change
    func onUpdate(data: Result<Model?, Error>, snapshot: DocumentSnapshot?)
}
