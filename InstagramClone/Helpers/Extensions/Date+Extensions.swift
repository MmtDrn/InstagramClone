//
//  Date+Extensions.swift
//  InstagramClone
//
//  Created by mehmet duran on 3.04.2023.
//

import UIKit

extension Date {
    
    public func add(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        let components = DateComponents(year: years, month: months, day: days, hour: hours, minute: minutes, second: seconds)
        return Calendar.current.date(byAdding: components, to: self)
    }
    
    public func subtract(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Int = 0) -> Date? {
        return add(years: -years, months: -months, days: -days, hours: -hours, minutes: -minutes, seconds: -seconds)
    }

    public static func daysBetweenDates(startDate: Date?, endDate: Date?) -> Int? {
        guard let startDate = startDate, let endDate = endDate else {
            return nil
        }

        let calendar = Calendar.current

        let components = calendar.dateComponents([.day], from: startDate, to: endDate)

        return components.day
    }
    
    public func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    public func isBetween(_ date1: Date?, and date2: Date?) -> Bool {
        guard let date1 = date1, let date2 = date2 else {
            return false
        }

        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
    
    public func isGreaterThanDateEx(_ dateToCompare : Date) -> Bool {
        var isGreater = false
        if self.compare(dateToCompare) == ComparisonResult.orderedDescending {
            isGreater = true
        }
        return isGreater
    }
}
