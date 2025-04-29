//
//  EDate.swift
//  MyiOSLibrary
//
//  Created by Vijay Sachan on 4/25/25.
//

import Foundation

// MARK: Formatting methods
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
// MARK: Utility methods
extension Date{
    public func mIsDateMonthYear(equalTo date:Date)->Bool{
        let dateComps_1=Calendar.current.dateComponents([.day,.month,.year], from: self)
        let dateComps_2=Calendar.current.dateComponents([.day,.month,.year], from: date)
        if dateComps_1.day==dateComps_2.day && dateComps_1.month==dateComps_2.month && dateComps_1.year==dateComps_2.year{
            return true
        }
        return false
    }
    public static func mDatesBetween(from fromDate: Date, to toDate: Date) -> [Date] {
        var dates: [Date] = []
        var date = fromDate
        while date <= toDate {
            dates.append(date)
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: date) else { break }
            date = newDate
        }
        return dates
    }
}
