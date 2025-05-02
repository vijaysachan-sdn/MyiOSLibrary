//
//  RealtimeDatabaseManager.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/30/25.
//
import Foundation
import FirebaseDatabase
public actor RealtimeDatabaseManager:FWLoggerDelegate{
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
