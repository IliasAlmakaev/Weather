//
//  LocationManager.swift
//  Weather
//
//  Created by Ilyas on 15.05.2025.
//

import Foundation
import CoreLocation

protocol LocationManagerProtocol {
  func requestLocation()
  var delegate: LocationManagerDelegate? { get set }
}

protocol LocationManagerDelegate: AnyObject {
  func didUpdateLocation(lat: Double, lon: Double)
  func didFailWithError(_ error: Error)
  func didChangeAuthorization(status: CLAuthorizationStatus)
}

final class LocationManager: NSObject, LocationManagerProtocol {
  
  weak var delegate: LocationManagerDelegate?
  
  private let locationManager = CLLocationManager()
  
  override init() {
    super.init()
    locationManager.delegate = self
  }
  
  func requestLocation() {
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestLocation()
  }
}

extension LocationManager: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    delegate?.didUpdateLocation(
      lat: location.coordinate.latitude,
      lon: location.coordinate.longitude
    )
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    delegate?.didFailWithError(error)
  }
  
  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    delegate?.didChangeAuthorization(status: manager.authorizationStatus)
  }
}
