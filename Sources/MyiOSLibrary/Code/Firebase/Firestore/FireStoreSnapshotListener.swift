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
    var path: String { get }
}
public protocol FireStoreCollectionSnapshotListener:FireStoreSnapshotListener{
    /// Called on collection changes
    func onUpdate(data: Result<[Model], Error>, snapshots: [QueryDocumentSnapshot]?)
}
public protocol FireStoreDocumentSnapshotListener:FireStoreSnapshotListener{
    /// Called on single document change
    func onUpdate(data: Result<Model?, Error>, snapshot: DocumentSnapshot?)
}
