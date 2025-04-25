//
//  TestFirestore.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/25/25.
//
import FirebaseFirestore
// MARK: Listen Collection
fileprivate class ListenCollection:FireStoreCollectionSnapshotListener{
    typealias Model = FirestoreManager.TestUser
    var listener: ListenerRegistration?
    func getRequestData(db:Firestore)->(pathToCollection: String, query: Query){
        let collectionReference = db.collection("users")
        let path=collectionReference.path
        let query=collectionReference.limit(to: 10)
        /*
         Also you can use :
         .order(by: "name")
         .whereField("country", isEqualTo: "USA")
         */
        return(path,query)
    }
    func onUpdate(data: Result<[MyiOSLibrary.FirestoreManager.TestUser], any Error>, snapshots: [QueryDocumentSnapshot]?) {
    }
    
    
}
// MARK: Listen Document
fileprivate class ListenDocument:FireStoreDocumentSnapshotListener{
    typealias Model = FirestoreManager.TestUser
    var listener: ListenerRegistration?
    var pathToDocument:String{
        let validDocPath="users/Drdjc4nbngrgzsS5Zael"
        let invalidDocPath="users/123456"
        return invalidDocPath
    }
    func onUpdate(data: Result<FirestoreManager.TestUser?, any Error>, snapshot: DocumentSnapshot?) {
        
    }
    
}
public class TestFirestore:@unchecked Sendable{
    public init(){ }
    fileprivate let collectionListener:ListenCollection = ListenCollection()
    fileprivate let documentListener:ListenDocument = ListenDocument()
    public func start(){
        Task{
            await FWFirebaseManager.shared.firestore.listenToCollection(listener: collectionListener)
            await FWFirebaseManager.shared.firestore.listenToDocument(listener: documentListener)
            
        }
    }
    public func stop(){
        Task{
            await FWFirebaseManager.shared.firestore.stopListening(listener: collectionListener)
            await FWFirebaseManager.shared.firestore.stopListening(listener: documentListener)
        }
    }
}
