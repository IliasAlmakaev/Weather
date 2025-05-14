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
  
  private let configuarator: WeatherInfoConfiguratorInputProtocol = WeatherInfoConfigurator()

  override func viewDidLoad() {
    super.viewDidLoad()
    configuarator.confugure(withView: self)
    setupUI()
  }

  private func setupUI() {
    view.backgroundColor = .white
    
    setupRefreshButton()
  }
  
  private func setupRefreshButton() {
    let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
    navigationItem.rightBarButtonItem = refreshButton
  }
  
  @objc private func refreshButtonTapped() {
    
  }
}

// MARK: - WeatherInfoViewInputProtocol
extension WeatherInfoViewController: WeatherInfoViewInputProtocol {
  
}

