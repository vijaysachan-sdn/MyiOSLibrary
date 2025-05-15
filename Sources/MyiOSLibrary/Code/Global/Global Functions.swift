//
//  Gloabl.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/28/25.
//
import Foundation
public func logThreadType(function:String = #function, tag:String){
    let threadName = Thread.isMainThread ? "Main Thread":"Background Thread"
    print("logThreadType : [\(tag)] : \(function) : thread :\(threadName)")
}

