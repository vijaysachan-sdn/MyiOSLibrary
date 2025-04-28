//
//  FWLogger.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/24/25.
//
import Foundation
import OSLog

public class FWLogger:@unchecked Sendable{
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
        logger.log(level: level, "\(self.getCurrentDateTimeWithSeconds()) :: FW :: \(tag) :: \(message)")
    }
    private func getCurrentDateTimeWithSeconds() -> String {
        // Get the current date and time
        let currentDate = Date()

        // Create a DateFormatter for the full date and time
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"  // Format to show date and time (year-month-day hours:minutes:seconds)

        // Format the current date and return it as a string
        return dateFormatter.string(from: currentDate)
    }

}
