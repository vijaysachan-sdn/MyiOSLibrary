//
//  RealtimeDatabaseManager.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/30/25.
//
import Foundation
import FirebaseDatabase
/**
  Using class because, let db=Database.database()
 db is not using async awat in FirebaseDatabase,If in future Google will implement it,then we cann replace class with actor
 */
public class RealtimeDatabaseManager:@unchecked Sendable,FWLoggerDelegate{
    protocol Functionality:AnyObject{
        init(manager:RealtimeDatabaseManager)
    }
    public let tag: String=String(describing: RealtimeDatabaseManager.self)
    public lazy var connectionState:RealtimeDatabaseConnectionState={
        return RealtimeDatabaseConnectionState(manager: self)
    }()
    let db:Database
    init (){
        db=Database.database()
    }
    
}
