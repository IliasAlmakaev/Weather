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
    interactor.requestLocation()
  }
  
  func getWeatherInfo() {
    interactor.getWeatherInfo()
  }
}

// MARK: - WeatherInfoInteractorOutputProtocol
extension WeatherInfoPresenter: WeatherInfoInteractorOutputProtocol {
  func didReceiveWeatherInfo(with dataStore: WeatherInfoDataStore) {
    
    self.dataStore = dataStore
    
    let currentWeatherInfoViewViewModel = CurrentWeatherInfoViewViewModel(weatherInfo: dataStore.weatherInfo)
    let collectionViewRows = getRows(with: dataStore)
    let tableViewRows: [WeatherDayInfoCellViewModel] = dataStore.weatherInfo.days.map { WeatherDayInfoCellViewModel(day: $0) }
    
    view.getWeatherInfo(
      forCurrentView: currentWeatherInfoViewViewModel,
      collectionViewRows: collectionViewRows,
      andTableViewRow: tableViewRows
    )
  }
  
  func didReceiveLocationError(_ error: Error) {
    view.showError(withMessage: error.localizedDescription)
  }
  
  private func getRows(with dataStore: WeatherInfoDataStore) -> [WeatherHourInfoCellViewModel] {
    let currentHourEpoch = dataStore.weatherInfo.currentTimeEpoch
    let todayLastHours = dataStore.weatherInfo.days[0].hours.filter { currentHourEpoch < $0.timeEpoch }
    let tomorrowHours = dataStore.weatherInfo.days[1].hours
    let hours = todayLastHours + tomorrowHours
    let rows: [WeatherHourInfoCellViewModel] = hours.map { WeatherHourInfoCellViewModel(hour: $0) }
    return rows
  }
}
