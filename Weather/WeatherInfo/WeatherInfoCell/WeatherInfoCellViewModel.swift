//
//  WeatherInfoCellViewModel.swift
//  Weather
//
//  Created by Ilyas on 14.05.2025.
//

import Foundation

protocol WeatherInfoCellViewModelProtocol {
  var cellIdentifier: String { get }
  var cellHeight: Double { get }
  var hour: String { get }
  var temperature: String { get }
  var imageUrl: URL? { get }
  var hourInfo: Hour { get }
  init(hour: Hour)
}

final class WeatherInfoCellViewModel: WeatherInfoCellViewModelProtocol {
  
  var cellIdentifier: String {
    "WeatherInfoCell"
  }
  
  var cellHeight: Double {
    90
  }
  
  var hour: String {
    getHour(with: hourInfo.timeEpoch)
  }
  
  var temperature: String {
    String(hourInfo.temperature) + "°"
  }
  
  var imageUrl: URL? {
    let urlString = "http:" + hourInfo.iconUrl
    return URL(string: urlString)
  }
  
  var hourInfo: Hour
  
  init(hour: Hour) {
    hourInfo = hour
  }
  
  private func getHour(with epochTime: Int) -> String {
    let date = Date(timeIntervalSince1970: TimeInterval(epochTime))
    let calendar = Calendar.current
    let hour = calendar.component(.hour, from: date)
    return String(hour)
  }
}
