//
//  WeatherInfoInteractor.swift
//  Weather
//
//  Created by Ilyas on 13.05.2025.
//

import Foundation
import CoreLocation

protocol WeatherInfoInteractorInputProtocol {
  func getWeatherInfo(withLatitude lat: Double, andLongitude lon: Double)
  func requestCurrentLocation()
}

protocol WeatherInfoInteractorOutputProtocol: AnyObject {
  func didReceiveLocation(lat: Double, lon: Double)
  func didReceiveLocationError(_ error: Error)
  func authorizationStatusChanged(_ status: CLAuthorizationStatus)
}

final class WeatherInfoInteractor: WeatherInfoInteractorInputProtocol {
  
  var networkManager: NetworkManagerProtocol!
  var locationManager: LocationManagerProtocol!
  
  private unowned let presenter: WeatherInfoInteractorOutputProtocol
  
  required init(presenter: WeatherInfoInteractorOutputProtocol) {
    self.presenter = presenter
  }
  
  func getWeatherInfo(withLatitude lat: Double, andLongitude lon: Double) {
    networkManager.getWeatherInfo(withLatitude:lat, andLongitude: lon) { [unowned self] result in
      print(result)
    }
  }
  
  func requestCurrentLocation() {
    locationManager.requestLocation()
  }
}

extension WeatherInfoInteractor: LocationManagerDelegate {
  
  func didUpdateLocation(lat: Double, lon: Double) {
    <#code#>
  }
  
  func didFailWithError(_ error: Error) {
    <#code#>
  }
  
  func didChangeAuthorization(status: CLAuthorizationStatus) {
    <#code#>
  }
}
