//
//  FWLoggerDelegate.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/25/25.
//

public protocol FWLoggerDelegate{
     var tag:String {get}
     func mLog(_ funcName:String,msg:String)
}
extension FWLoggerDelegate{
    public func mLog(_ funcName:String=#function,msg:String){
        let tag:String = self.tag
        Task {
            await FWLogger.shared.info(tag:tag,message: funcName+" :: "+msg)
        }
    }
}
