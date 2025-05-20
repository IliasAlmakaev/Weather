//
//  Extension + Int.swift
//  Weather
//
//  Created by Ilyas on 20.05.2025.
//

import Foundation

extension Int {
  
  var getHour: String {
    let date = Date(timeIntervalSince1970: TimeInterval(self))
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    return String(hour)
  }
  
  var getDay: String {
    let date = Date(timeIntervalSince1970: TimeInterval(self))
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale.current
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = "EEE"
    
    let dayName = dateFormatter.string(from: date)
    
    return dayName
  }
}
