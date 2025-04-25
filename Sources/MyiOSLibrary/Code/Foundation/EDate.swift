//
//  EDate.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/25/25.
//

import Foundation
extension Date{
    /// - Returns: 4/25/2025, 3:05 PM
    public func fw_formatted()->String{
        return formatted()
    }
    /**
     - Returns: 2025-04-25 14:30:45
     */
    public func fw_customFormatted()->String{
        let date = Date()
        // Custom formatted date (e.g., year-month-day hour:minute:second)
        let formattedDate = date.formatted(.dateTime.year().month().day().hour().minute().second())
        return formattedDate
    }
}
