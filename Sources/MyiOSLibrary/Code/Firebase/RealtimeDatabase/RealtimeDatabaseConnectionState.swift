//
//  RealtimeDatabaseConnectionState.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 5/2/25.
//
import FirebaseDatabase
public class RealtimeDatabaseConnectionState:RealtimeDatabaseManager.Functionality,FWLoggerDelegate{
    
    public let tag: String=String(describing: RealtimeDatabaseConnectionState.self)
    
    public protocol Delegate:AnyObject {
        func onConnectionStateChanged(isConnected: Bool)
    }
    weak var manager: RealtimeDatabaseManager!
    private var connectedRef:DatabaseReference!
    private var isConnected:Bool=false
    private var activeConnectionStateListeners = NSHashTable<AnyObject>.weakObjects()
    
    required init(manager: RealtimeDatabaseManager){
        self.manager = manager
        startListeningForConnectionState(manager.db)
    }
     func startListeningForConnectionState(_ db:Database) {
        connectedRef = db.reference(withPath: ".info/connected")
        connectedRef.observe(.value, with: { snapshot in
            var isConnected=false
            if snapshot.value as? Bool ?? false {
                isConnected=true
                self.mLog(msg:"Connected")
            } else {
                isConnected=false
                self.mLog(msg:"Not Connected")
            }
            self.notifyConnectionStateListeners(isConnected)
        })
    }
    private func notifyConnectionStateListeners(_ isConnected:Bool) {
        self.isConnected=isConnected
        for listener in activeConnectionStateListeners.allObjects {
            if let listener = listener as? RealtimeDatabaseConnectionState.Delegate {
                listener.onConnectionStateChanged(isConnected: isConnected)
            }
        }
    }
    public func addConnectionStateListener(_ listener: Delegate){
        if activeConnectionStateListeners.contains(listener){
            mLog(msg:"❌ Listener already registered..............stopping ❌")
            removeConnectionStateListener(listener)
        }
        activeConnectionStateListeners.add(listener)
        listener.onConnectionStateChanged(isConnected: isConnected)
        mLog(msg: "Total active \(activeConnectionStateListeners.count)")
    }
    public func removeConnectionStateListener(_ listener: Delegate) {
        activeConnectionStateListeners.remove(listener)
        mLog(msg: "Total active \(activeConnectionStateListeners.count)")
    }
}
