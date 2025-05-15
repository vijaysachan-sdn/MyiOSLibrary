//
//  FirestoreManager.swift
//  MAPS
//
//  Created by Vijay Sachan on 4/23/25.
//

import Foundation
import FirebaseFirestore

public actor FirestoreManager:FWLoggerDelegate{
    public let tag:String=String(describing: FirestoreManager.self)
    public let db:Firestore
    /**
     "In **NSHashTable<AnyObject>**, if two variables are referring to the same object, it will only add the object once. It behaves similarly to a **Set** in this regard, ensuring that duplicates are not added."
     This version clarifies that:
     The comparison is based on reference equality (the same object).
     **The behavior is similar to a Set, which ensures uniqueness**
     */
    private var activeUniqueListeners = NSHashTable<AnyObject>.weakObjects()
    init(cacheMode: FirestoreCacheMode = .persistent()){
        let settings = FirestoreSettings()
        switch cacheMode {
        case .persistent(let sizeInBytes):
            settings.cacheSettings = PersistentCacheSettings(sizeBytes: NSNumber(value: sizeInBytes))
        case .inMemory:
            settings.cacheSettings = MemoryCacheSettings()
        }
        db = Firestore.firestore()
        db.settings = settings
    }
    private func storeRegistration<T: FireStoreSnapshotListener>(_ path:String,
                                                                 _ registration: ListenerRegistration,
                                                                 for listener: T
    ){
        if activeUniqueListeners.contains(listener){
            mLog(msg:"❌ Listener for \(path)) already registered..............stopping ❌")
            stopListening(listener: listener)
        }
        listener.listener = registration
        activeUniqueListeners.add(listener)
        mLog(msg:"\(path) : Total active listeners: \(activeUniqueListeners.count)")
    }
    public func stopListening<T: FireStoreSnapshotListener>(listener:T){
        listener.listener?.remove()
        listener.listener = nil
        activeUniqueListeners.remove(listener)
        mLog(msg:"Total active listeners: \(activeUniqueListeners.count)")
    }
    struct TestUser: Identifiable, Codable {
        @DocumentID public var id: String? // Provided by FirebaseFirestoreSwift
        public var name: String
    }
    
}
// MARK: Listeners
extension FirestoreManager{
    public func listenToCollection<T: FireStoreCollectionSnapshotListener>(listener:T){
        let requestData=listener.getRequestData(db: db)
        let prefiX="Path : \(requestData.pathToCollection), "
        let registration = requestData.query
            .addSnapshotListener { [weak self] snapshot, error in
                guard let self=self else {return}
                if let error=error{
                    mLog(msg:"\(prefiX) Error : \(error.localizedDescription)")
                    listener.onUpdate(data: .failure(error), snapshots: nil)
                    return
                }
                guard let documents = snapshot?.documents else {
                    mLog(msg: "\(prefiX) No documents found")
                    listener.onUpdate(data: .success([]), snapshots: [])
                    return
                }
                var decoded: [T.Model] = []
                var rawSnapshots: [QueryDocumentSnapshot] = []
                
                for doc in documents {
                    do {
                        let model = try doc.data(as: T.Model.self)
                        decoded.append(model)
                        rawSnapshots.append(doc)
                    } catch {
                        mLog(msg: "\(prefiX) Skipping invalid document: \(doc.documentID) - \(error.localizedDescription)")
                    }
                }
                listener.onUpdate(data: .success(decoded), snapshots: rawSnapshots)
                mLog(msg: "\(prefiX) Total received docs = \(documents.count)  : Total valid docs: \(decoded.count)")
            }
        storeRegistration(prefiX,registration, for: listener)
    }
    /**
     1. For some unknown reason, if the document is not present or exists, the code reaches the following decoding error:
     
     **"Decoding error: The data couldn’t be read because it is missing."**
     
     But it should be reaching to **"Document does not exist"**
     */
    public func listenToDocument<T: FireStoreDocumentSnapshotListener>(listener: T) {
        let path = listener.pathToDocument
        let prefiX = "Path: \(path)"
        let registration = db.document(path).addSnapshotListener {[weak self] snapshot, error in
            guard let self=self else {return}
            if let error = error{
                mLog(msg:"\(prefiX) Error: \(error.localizedDescription)")
                listener.onUpdate(data: .failure(error), snapshot: snapshot)
                return
            }
            guard let document = snapshot else{
                mLog(msg:"\(prefiX) Document does not exist")
                listener.onUpdate(data: .success(nil), snapshot: nil)
                return
            }
            do {
                let model = try document.data(as: T.Model.self)
                mLog(msg: "\(prefiX) Successfully decoded document")
                listener.onUpdate(data: .success(model),snapshot: document)
            } catch {
                mLog(msg: "\(prefiX) Decoding error: \(error.localizedDescription)")
                listener.onUpdate(data: .failure(error), snapshot: document)
            }
        }
        storeRegistration(prefiX,registration, for: listener)
    }
}
