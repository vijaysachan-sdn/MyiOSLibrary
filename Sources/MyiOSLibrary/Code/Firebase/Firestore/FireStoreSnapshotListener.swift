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
    func onUpdate(data: Result<[Model]?, Error>)
    var path: String { get }
}
