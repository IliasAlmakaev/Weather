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
    let rows: [WeatherInfoCellViewModel] = dataStore.weatherInfo.days[0].hours.map { WeatherInfoCellViewModel(hour: $0) }
    view.getWeatherInfo(for: rows)
  }
  
  func didReceiveLocation(lat: Double, lon: Double) {
    
  }
  
  func didReceiveLocationError(_ error: Error) {
    
  }
  
  
}
