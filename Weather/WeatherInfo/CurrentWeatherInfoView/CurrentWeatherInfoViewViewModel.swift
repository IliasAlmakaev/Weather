//
//  CurrentWeatherInfoViewViewModel.swift
//  Weather
//
//  Created by Ilyas on 20.05.2025.
//

import Foundation

protocol CurrentWeatherInfoViewViewModelProtocol {
  var hour: String { get }
  var temperature: String { get }
  var imageUrl: URL? { get }
  var weatherInfo: WeatherInfo { get }
  init(weatherInfo: WeatherInfo)
}

final class CurrentWeatherInfoViewViewModel: CurrentWeatherInfoViewViewModelProtocol {
  
  var hour: String {
    weatherInfo.currentTimeEpoch.getHour
  }
  
  var temperature: String {
    weatherInfo.currentTemperature.withDegreesCelsius
  }
  
  var imageUrl: URL? {
    weatherInfo.iconUrl.imageUrl
  }
  
  var weatherInfo: WeatherInfo
  
  init(weatherInfo: WeatherInfo) {
    self.weatherInfo = weatherInfo
  }
}
