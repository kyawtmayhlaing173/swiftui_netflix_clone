//
//  DateManager.swift
//  swiftui_netflix_clone
//
//  Created by Kyawt May Hlaing on 29/11/2024.
//

import Foundation

class DateManager {
    func getYearFromDateString(dateString: String?) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let currentYear = Calendar.current.component(.year, from: Date())
        
        guard let dateString = dateString else { return currentYear }
        
        if let date = dateFormatter.date(from: dateString) {
            let year = Calendar.current.component(.year, from: date)
            return year
        } else {
            return currentYear
        }
    }
    
    func getCurrentYear() -> Int {
        let currentYear = Calendar.current.component(.year, from: Date())
        return currentYear
    }
    
    func getFormattedShowTime(with minutes: Int?) -> String {
        if let minutes = minutes {
            let hours = minutes / 60
            let remainingMinutes = minutes % 60
            
            if hours > 0 {
                return "\(hours)h \(remainingMinutes)m"
            } else {
                return "\(remainingMinutes)m"
            }
        } else {
            return ""
        }
    }
}
