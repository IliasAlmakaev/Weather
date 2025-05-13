//
//  WeatherInfoInteractor.swift
//  Weather
//
//  Created by Ilyas on 13.05.2025.
//

import Foundation

protocol WeatherInfoInteractorInputProtocol {
  
}

protocol WeatherInfoInteractorOutputProtocol: AnyObject {
  
}

final class WeatherInfoInteractor: WeatherInfoInteractorInputProtocol {
  
  private unowned let presenter: WeatherInfoInteractorOutputProtocol
  
  required init(presenter: WeatherInfoInteractorOutputProtocol) {
    self.presenter = presenter
  }
}
