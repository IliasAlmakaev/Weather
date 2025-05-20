//
//  CurrentWeatherInfoView.swift
//  Weather
//
//  Created by Ilyas on 20.05.2025.
//

import UIKit
import SDWebImage

final class CurrentWeatherInfoView: UIView {
  
  var viewModel: CurrentWeatherInfoViewViewModelProtocol? {
    didSet {
      updateView()
    }
  }
  
  private var hourLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private var temperatureLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func updateView() {
    guard let viewModel = viewModel as? CurrentWeatherInfoViewViewModel else { return }
    
    imageView.sd_setImage(with: viewModel.imageUrl)
    hourLabel.text = viewModel.hour
    temperatureLabel.text = viewModel.temperature
  }
  
  private func setupView() {
    addSubview(hourLabel)
    addSubview(temperatureLabel)
    addSubview(imageView)
    
    NSLayoutConstraint.activate([
      hourLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
      hourLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      imageView.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 10),
      imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 60),
      imageView.heightAnchor.constraint(equalToConstant: 60),
      temperatureLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
      temperatureLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    ])
  }
}

