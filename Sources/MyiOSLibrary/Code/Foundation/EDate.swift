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
// MARK: Test
extension Date:FWLoggerDelegate{
    public var tag: String {
        return String(describing: Date.self)
    }
    
    func fw_test(){
        let date = Date(timeIntervalSince1970:TimeInterval(1745909408))
        mLog(msg: date.formatted())// 4/29/2025, 12:20 PM
        testDateTime(date)
        testRelative(date)
        testIso8601(date)
    }
    /// Notes:
    /// The exact output depends on the user's locale (`.locale(.current)`) or We can say "Device date time format settings", which affects:
    /// - Language
    /// - Date order
    /// - Time format (12-hour vs. 24-hour)
    /// - Time zone name/format
    
    private func testDateTime(_ date:Date){
//        mLog(msg: date.formatted(.dateTime))// 4/29/2025, 12:20 PM
//        mLog(msg: date.formatted(.dateTime.year().month().day().weekday().hour().minute().second().timeZone().locale(.current)))// Tue, Apr 29, 2025 at 12:20:8 PM GMT+5:30
//        // Year
//        mLog(msg: date.formatted(.dateTime.year()))// 2025
//        mLog(msg: date.formatted(.dateTime.year(.defaultDigits)))// 2025
//        mLog(msg: date.formatted(.dateTime.year(.twoDigits)))// 25
//        mLog(msg: date.formatted(.dateTime.year(.padded(6))))// 002025
//        // Month
//        mLog(msg: date.formatted(.dateTime.month())) // Apr
//        mLog(msg: date.formatted(.dateTime.month(.abbreviated))) // Apr
//        mLog(msg: date.formatted(.dateTime.month(.narrow))) // A
//        mLog(msg: date.formatted(.dateTime.month(.defaultDigits))) // 4
//        mLog(msg: date.formatted(.dateTime.month(.twoDigits))) // 04
//        mLog(msg: date.formatted(.dateTime.month(.wide))) // April
//        // Day
//        mLog(msg: date.formatted(Date.FormatStyle().day(.defaultDigits))) // 29
//        mLog(msg: date.formatted(Date.FormatStyle().day(.ordinalOfDayInMonth))) // 5 (It is the 5th Tuesday of the month)
//        mLog(msg: date.formatted(Date.FormatStyle().day(.twoDigits))) // 29 // 09(If date was 9)
//        mLog(msg: date.formatted(Date.FormatStyle().day())) // 29 // 9(If date was 9)
//        // Weekday
        mLog(msg: date.formatted(Date.FormatStyle().weekday())) // Tue
        mLog(msg: date.formatted(Date.FormatStyle().weekday(.abbreviated))) // Tue
        mLog(msg: date.formatted(Date.FormatStyle().weekday(.narrow))) // T
        mLog(msg: date.formatted(Date.FormatStyle().weekday(.oneDigit))) // 3
        mLog(msg: date.formatted(Date.FormatStyle().weekday(.short))) // Tu
        mLog(msg: date.formatted(Date.FormatStyle().weekday(.twoDigits))) // 3
        mLog(msg: date.formatted(Date.FormatStyle().weekday(.wide))) // Tuesday
    }
    private func testRelative(_ date:Date){
        
    }
    private func testIso8601(_ date:Date){
        
    }
}
