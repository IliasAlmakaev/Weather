//
//  WeatherInfoConfigurator.swift
//  Weather
//
//  Created by Ilyas on 13.05.2025.
//

import Foundation

protocol WeatherInfoConfiguratorInputProtocol {
  func confugure(withView view: WeatherInfoViewController)
}

final class WeatherInfoConfigurator: WeatherInfoConfiguratorInputProtocol {
  func confugure(withView view: WeatherInfoViewController) {
    let presenter = WeatherInfoPresenter(view: view)
    let interactor = WeatherInfoInteractor(presenter: presenter)
    
    view.presenter = presenter
    presenter.interactor = interactor
    interactor.networkManager = NetworkManager()
    interactor.locationManager = LocationManager()
  }
}
