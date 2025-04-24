//
//  FirestoreManager.swift
//  MAPS
//
//  Created by Vijay Sachan on 4/23/25.
//
import Foundation
import FirebaseFirestore

public actor FirestoreManager{
    let db:Firestore
    private var activeListeners = NSHashTable<AnyObject>.weakObjects()
    init(cacheMode: FirestoreCacheMode = .persistent()) {
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
    public func listenToCollection<T: FireStoreCollectionSnapshotListener>(listener:T,limit:Int){
        let prefiX="Path : \(listener.path)"
        let registration = db.collection(listener.path).limit(to: limit)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error=error{
                    self?.mLog(msg:"\(prefiX) Error : \(error.localizedDescription)")
                    listener.onUpdate(data: .failure(error), snapshots: nil)
                    return
                }
                guard let documents = snapshot?.documents else {
                    self?.mLog(msg: "\(prefiX) No documents found")
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
                        self?.mLog(msg: "\(prefiX) Skipping invalid document: \(doc.documentID) - \(error.localizedDescription)")
                    }
                }
                listener.onUpdate(data: .success(decoded), snapshots: rawSnapshots)
                self?.mLog(msg: "\(prefiX) Total received docs = \(documents.count)  : Total valid docs: \(decoded.count)")
            }
        storeRegistration(registration, for: listener)
    }
    public func listenToDocument<T: FireStoreDocumentSnapshotListener>(listener: T) {
        let path = listener.path
        let prefiX = "Path: \(path)"
        let registration = db.document(path).addSnapshotListener {[weak self] snapshot, error in
            if let error = error {
                self?.mLog(msg:"\(prefiX) Error: \(error.localizedDescription)")
                listener.onUpdate(data: .failure(error), snapshot: snapshot)
                return
            }
            guard let document = snapshot else{
                self?.mLog(msg:"\(prefiX) Document does not exist")
                listener.onUpdate(data: .success(nil), snapshot: nil)
                return
            }
            do {
                let model = try document.data(as: T.Model.self)
                self?.mLog(msg: "\(prefiX) Successfully decoded document")
                listener.onUpdate(data: .success([model]), snapshot: document)
            } catch {
                self?.mLog(msg: "\(prefiX) Decoding error: \(error.localizedDescription)")
                listener.onUpdate(data: .failure(error), snapshot: document)
            }
        }
        storeRegistration(registration, for: listener)
    }
    private func storeRegistration<T: FireStoreSnapshotListener>(
        _ registration: ListenerRegistration,
        for listener: T
    ) {
        listener.listener = registration
        activeListeners.add(listener)
        mLog(msg:"Total active listeners: \(activeListeners.count)")
    }
    public func stopListening<T: FireStoreSnapshotListener>(listener:T){
        listener.listener?.remove()
        listener.listener = nil
        activeListeners.remove(listener)
        mLog(msg:"Total active listeners: \(activeListeners.count)")
    }
    nonisolated
    private func mLog(_ funcName:String=#function,msg:String){
        Task{
            await FWLogger.shared.info(tag: String(describing: type(of: self)), message: msg)
        }
    }
    public struct TestUser: Identifiable, Codable {
        @DocumentID public var id: String? // Provided by FirebaseFirestoreSwift
        public var name: String
    }
}
