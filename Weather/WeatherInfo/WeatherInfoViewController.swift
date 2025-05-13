//
//  WeatherInfoViewController.swift
//  Weather
//
//  Created by Ilyas on 13.05.2025.
//

import UIKit

protocol WeatherInfoViewInputProtocol: AnyObject {
  
}

protocol WeatherInfoViewOutputProtocol {
  
}

class WeatherInfoViewController: UIViewController {
  
  var presenter: WeatherInfoViewOutputProtocol!
  
  private let configuartor: WeatherInfoConfiguratorInputProtocol = WeatherInfoConfigurator()

  override func viewDidLoad() {
    super.viewDidLoad()
    configuartor.confugure(withView: self)
    setupUI()
  }

  private func setupUI() {
  }
}

// MARK: - WeatherInfoViewInputProtocol
extension WeatherInfoViewController: WeatherInfoViewInputProtocol {
  
}

