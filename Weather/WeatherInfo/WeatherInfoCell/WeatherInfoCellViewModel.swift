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
    110
  }
  
  var hour: String {
    hourInfo.timeEpoch.getHour
  }
  
  var temperature: String {
    hourInfo.temperature.withDegreesCelsius
  }
  
  var imageUrl: URL? {
    hourInfo.iconUrl.imageUrl
  }
  
  var hourInfo: Hour
  
  init(hour: Hour) {
    hourInfo = hour
  }
}
