//
//  WeatherInfoPresenter.swift
//  Weather
//
//  Created by Ilyas on 13.05.2025.
//

import Foundation

struct WeatherInfoDataStore {
  
}

final class WeatherInfoPresenter: WeatherInfoViewOutputProtocol {
  
  var interactor: WeatherInfoInteractorInputProtocol!
  
  private unowned let view: WeatherInfoViewInputProtocol
  private var dataStore: WeatherInfoDataStore?
  
  required init(view: WeatherInfoViewInputProtocol) {
    self.view = view
  }
  
  func viewDidLoad() {
    interactor.getWeatherInfo()
    interactor.requestCurrentLocation()
  }
}

// MARK: - WeatherInfoInteractorOutputProtocol
extension WeatherInfoPresenter: WeatherInfoInteractorOutputProtocol {
  func didReceiveLocation(lat: Double, lon: Double) {
    <#code#>
  }
  
  func didReceiveLocationError(_ error: Error) {
    <#code#>
  }
  
  func authorizationStatusChanged(_ status: CLAuthorizationStatus) {
    <#code#>
  }
  
  
}
