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
}
