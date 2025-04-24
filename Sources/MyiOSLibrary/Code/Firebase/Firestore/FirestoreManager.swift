//
//  FirestoreManager.swift
//  MAPS
//
//  Created by Vijay Sachan on 4/23/25.
//
import Foundation
import FirebaseFirestore

public class FirestoreManager{
    let db:Firestore
    private var activeListeners = NSHashTable<AnyObject>.weakObjects()
     init () {
        db=Firestore.firestore()
    }
    public func listenToCollection<T: FireStoreSnapshotListener>(listener:T){
        let prefiX="Path : \(listener.path)"
        let registration = db.collection(listener.path)
            .addSnapshotListener { [weak self] snapshot, error in
                if let error=error{
                    self?.mLog(msg:"\(prefiX) Error : \(error.localizedDescription)")
                    listener.onUpdate(data: .failure(error))
                    return
                }
                guard let documents = snapshot?.documents else {
                    self?.mLog(msg:"\(prefiX) No documents found")
                    listener.onUpdate(data: .success([]))
                    return
                }
                let arr=documents.compactMap { doc -> T.Model? in
                    if let model=try? doc.data(as: T.Model.self){
                        return model
                    }
                    self?.mLog(msg:"\(prefiX) Unable to decode document")
                    return nil
                }
                listener.onUpdate(data: .success(arr))
                self?.mLog(msg:"\(prefiX) Total docs: \(arr.count)")
            }
        storeRegistration(registration, for: listener)
    }
    public func listenToDocument<T: FireStoreSnapshotListener>(listener: T) {
        let path = listener.path
        let prefiX = "Path: \(path)"
        let registration = db.document(path).addSnapshotListener {[weak self] snapshot, error in
            if let error = error {
                self?.mLog(msg:"\(prefiX) Error: \(error.localizedDescription)")
                listener.onUpdate(data: .failure(error))
                return
            }
            guard let document = snapshot else{
                self?.mLog(msg:"\(prefiX) Document does not exist")
                listener.onUpdate(data: .success(nil)) // Single document returns optional
                return
            }
            do {
                let model = try document.data(as: T.Model.self)
                self?.mLog(msg:"\(prefiX) Successfully decoded document")
                listener.onUpdate(data: .success([model]))  // Wrap in array for consistency
            } catch {
                self?.mLog(msg:"\(prefiX) Decoding error: \(error.localizedDescription)")
                listener.onUpdate(data: .failure(error))
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
    private func mLog(_ funcName:String=#function,msg:String){
//        AH.mLog(tag: String(describing: type(of: self)), subTag: funcName, msg: msg)
        print("[\(String(describing: type(of: self)))] [\(funcName)]: \(msg)")
    }
    
    public struct TestUser: Identifiable, Codable {
         @DocumentID public var id: String? // Provided by FirebaseFirestoreSwift
        public var name: String
    }
}
