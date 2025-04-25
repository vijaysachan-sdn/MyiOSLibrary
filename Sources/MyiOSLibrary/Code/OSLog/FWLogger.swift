//
//  FWLogger.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/24/25.
//
import Foundation
import OSLog
public actor FWLogger{
    // Singleton pattern for shared instance
    public static let shared = FWLogger()

    // Internal logger using Apple's os.Logger
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "FWLogger", category: "FW")

    // Flag to control logging
    public var isLoggingEnabled: Bool = true

    private init() {}

    // MARK: - Logging Methods
    public func info(tag: String, message: String){
         log(level: .info, tag: tag, message: message)
    }

    public func error(tag: String, message: String) {
         log(level: .error, tag: tag, message: message)
    }

    public func debug(tag: String, message: String) {
         log(level: .debug, tag: tag, message: message)
    }

    public func fault(tag: String, message: String) {
         log(level: .fault, tag: tag, message: message)
    }

    // MARK: - Internal Helper

    private func log(level: OSLogType, tag: String, message: String) {
        guard isLoggingEnabled else { return }
        logger.log(level: level, "\(Date().fw_formatted()) :: FW :: \(tag) :: \(message)")
    }
}
