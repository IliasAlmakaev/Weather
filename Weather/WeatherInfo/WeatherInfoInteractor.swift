//
//  WeatherInfoInteractor.swift
//  Weather
//
//  Created by Ilyas on 13.05.2025.
//

import Foundation
import CoreLocation

protocol WeatherInfoInteractorInputProtocol {
  func getWeatherInfo()
  func requestLocation()
}

protocol WeatherInfoInteractorOutputProtocol: AnyObject {
  func didReceiveWeatherInfo(with dataStore: WeatherInfoDataStore)
  func didReceiveLocationError(_ error: Error)
}

final class WeatherInfoInteractor: WeatherInfoInteractorInputProtocol {
  
  var networkManager: NetworkManagerProtocol!
  var locationManager: LocationManagerProtocol!
  var location: CLLocation?
  var setMoscow = false
  
  private unowned let presenter: WeatherInfoInteractorOutputProtocol
  
  required init(presenter: WeatherInfoInteractorOutputProtocol) {
    self.presenter = presenter
  }
  
  func getWeatherInfo() {
    guard let latitude = location?.coordinate.latitude,
          let longitude = location?.coordinate.longitude else { return }
    
    getWeatherInfo(withLatitude: latitude, andLongitude: longitude)
  }
  
  func getWeatherInfo(withLatitude lat: Double, andLongitude lon: Double) {
    
    var latitude: Double!
    var longitude: Double!
    
    if let location = location, setMoscow {
      latitude = location.coordinate.latitude
      longitude = location.coordinate.longitude
    } else {
      latitude = lat
      longitude = lon
      location = CLLocation(latitude: lat, longitude: lon)
    }
    
    networkManager.getWeatherInfo(withLatitude:latitude, andLongitude: longitude) { [unowned self] result in
      switch result {
      case .success(let weatherInfo):
        let dataStore = WeatherInfoDataStore(weatherInfo: weatherInfo)
        presenter.didReceiveWeatherInfo(with: dataStore)
      case .failure(let error):
        print(error)
        presenter.didReceiveLocationError(error)
      }
    }
  }
  
  func requestLocation() {
    locationManager.requestLocation()
  }
}

extension WeatherInfoInteractor: LocationManagerDelegate {
  
  func didUpdateLocation(lat: Double, lon: Double) {
    getWeatherInfo(withLatitude: lat, andLongitude: lon)
  }
  
  func didFailWithError(_ error: Error) {
    guard error._code != 1 else { return }
    presenter.didReceiveLocationError(error)
  }
  
  func didChangeAuthorization(status: CLAuthorizationStatus) {
    
    switch status {
    case .denied, .restricted:
      
      // Set Moscow coordinates
      setMoscow = true
      let lat = 55.7558
      let lon = 37.6173
      
      location = CLLocation(latitude: lat, longitude: lon)
      getWeatherInfo(withLatitude: lat, andLongitude: lon)
    default:
      break
    }
  }
}
