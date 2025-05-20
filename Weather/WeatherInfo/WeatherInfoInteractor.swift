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
  func didReceiveWeatherInfo(with dataStore: WeatherInfoDataStore)
  func didReceiveLocation(lat: Double, lon: Double)
  func didReceiveLocationError(_ error: Error)
}

final class WeatherInfoInteractor: WeatherInfoInteractorInputProtocol {
  
  var networkManager: NetworkManagerProtocol!
  var locationManager: LocationManagerProtocol!
  var location: CLLocation?
  
  private unowned let presenter: WeatherInfoInteractorOutputProtocol
  
  required init(presenter: WeatherInfoInteractorOutputProtocol) {
    self.presenter = presenter
  }
  
  func getWeatherInfo(withLatitude lat: Double, andLongitude lon: Double) {
    networkManager.getWeatherInfo(withLatitude:lat, andLongitude: lon) { [unowned self] result in
      switch result {
      case .success(let weatherInfo):
        let dataStore = WeatherInfoDataStore(weatherInfo: weatherInfo)
        presenter.didReceiveWeatherInfo(with: dataStore)
      case .failure(let error):
        // TODO: - Показывать пользователю ошибку
        print(error)
      }
    }
  }
  
  func requestCurrentLocation() {
    locationManager.requestLocation()
  }
}

extension WeatherInfoInteractor: LocationManagerDelegate {
  
  func didUpdateLocation(lat: Double, lon: Double) {
    
    var latitude: Double!
    var longitude: Double!
    
    if let location = location {
      latitude = location.coordinate.latitude
      longitude = location.coordinate.longitude
    } else {
      latitude = lat
      longitude = lon
    }
    
    getWeatherInfo(withLatitude: latitude, andLongitude: longitude)
  }
  
  func didFailWithError(_ error: Error) {
    // TODO: - Добавить обработку ошибку
  }
  
  func didChangeAuthorization(status: CLAuthorizationStatus) {
    
    switch status {
    case .denied, .restricted:
      
      // Set Moscow coordinates
      let lat = 55.7558
      let lon = 37.6173
      
      location = CLLocation(latitude: lat, longitude: lon)
      getWeatherInfo(withLatitude: lat, andLongitude: lon)
    default:
      break
    }
  }
}
