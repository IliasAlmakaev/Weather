//
//  WeatherInfoInteractor.swift
//  Weather
//
//  Created by Ilyas on 13.05.2025.
//

import Foundation

protocol WeatherInfoInteractorInputProtocol {
  func getWeatherInfo()
}

protocol WeatherInfoInteractorOutputProtocol: AnyObject {
  
}

final class WeatherInfoInteractor: WeatherInfoInteractorInputProtocol {
  
  private unowned let presenter: WeatherInfoInteractorOutputProtocol
  private let networkManager = NetworkManager.shared
  
  required init(presenter: WeatherInfoInteractorOutputProtocol) {
    self.presenter = presenter
  }
  
  func getWeatherInfo() {
    networkManager.getWeatherInfo(withCity: "Kemerovo") { [unowned self] result in
      print(result)
    }
  }
}
