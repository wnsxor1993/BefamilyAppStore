//
//  DateConverter.swift
//  BefamilyAppStore
//
//  Created by juntaek.oh on 2022/08/08.
//

import Foundation

struct DateConverter {
    
    static func calculateToday(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:SSZ"
        guard let date = dateFormatter.date(from: date) else { return "" }
        
        let offsetComps = Calendar.current.dateComponents([.year, .month, .day, .hour], from: date, to: Date())
        
        if let year = offsetComps.year, year > 0 {
            return "\(year)년 전"
            
        } else if let month = offsetComps.month, month > 0 {
            return "\(month)개월 전"
            
        } else if let day = offsetComps.day, day > 0 {
            return "\(day)일 전"
            
        } else {
            return ""
        }
    }
    
    static func calculateYear(from date: String) -> String {
        let temp = date.components(separatedBy: "-")
        return temp[0]
    }
}
