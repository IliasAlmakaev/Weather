//
//  WeatherInfoPresenter.swift
//  Weather
//
//  Created by Ilyas on 13.05.2025.
//

import Foundation

struct WeatherInfoDataStore {
  let weatherInfo: WeatherInfo
}

final class WeatherInfoPresenter: WeatherInfoViewOutputProtocol {
  
  var interactor: WeatherInfoInteractorInputProtocol!
  
  private unowned let view: WeatherInfoViewInputProtocol
  private var dataStore: WeatherInfoDataStore?
  
  required init(view: WeatherInfoViewInputProtocol) {
    self.view = view
  }
  
  func viewDidLoad() {
    interactor.requestCurrentLocation()
  }
}

// MARK: - WeatherInfoInteractorOutputProtocol
extension WeatherInfoPresenter: WeatherInfoInteractorOutputProtocol {
  func didReceiveWeatherInfo(with dataStore: WeatherInfoDataStore) {
    self.dataStore = dataStore
    view.getWeatherInfo(for: getRows(with: dataStore))
  }
  
  func didReceiveLocation(lat: Double, lon: Double) {
    
  }
  
  func didReceiveLocationError(_ error: Error) {
    
  }
  
  private func getRows(with dataStore: WeatherInfoDataStore) -> [WeatherInfoCellViewModel] {
    let currentHourEpoch = dataStore.weatherInfo.currentTimeEpoch
    let currentDays = dataStore.weatherInfo.days[0].hours
    let todayFirstHours = currentDays.filter { currentHourEpoch >= $0.timeEpoch }
    let todayLastHours = currentDays.filter { currentHourEpoch < $0.timeEpoch }
    let tomorrowHours = dataStore.weatherInfo.days[1].hours
    let hours = [todayFirstHours[todayFirstHours.count - 1]] + todayLastHours + tomorrowHours
    let rows: [WeatherInfoCellViewModel] = hours.map { WeatherInfoCellViewModel(hour: $0) }
    return rows
  }
}
