//
//  WeatherDayInfoCellVewModel.swift
//  Weather
//
//  Created by Ilyas on 20.05.2025.
//

import Foundation

protocol WeatherDayInfoCellViewModelProtocol {
  var cellIdentifier: String { get }
  var cellHeight: Double { get }
  var day: String { get }
  var temperature: String { get }
  var imageUrl: URL? { get }
  var dayInfo: Day { get }
  init(day: Day)
}

final class WeatherDayInfoCellViewModel: WeatherDayInfoCellViewModelProtocol {
  
  var cellIdentifier: String {
    "WeatherDayInfoCell"
  }
  
  var cellHeight: Double {
    110
  }
  
  var day: String {
    dayInfo.timeEpoch.getDay
  }
  
  var temperature: String {
   "От \(dayInfo.minTemperature.withDegreesCelsius) до \(dayInfo.maxTemperature.withDegreesCelsius)"
  }
  
  var imageUrl: URL? {
    dayInfo.iconUrl.imageUrl
  }
  
  var dayInfo: Day
  
  init(day: Day) {
    dayInfo = day
  }
}
