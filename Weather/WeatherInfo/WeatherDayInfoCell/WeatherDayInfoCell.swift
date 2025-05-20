//
//  WeatherDayInfoCell.swift
//  Weather
//
//  Created by Ilyas on 20.05.2025.
//

import UIKit
import SDWebImage

final class WeatherDayInfoCell: UITableViewCell {
  
  var viewModel: WeatherDayInfoCellViewModelProtocol? {
    didSet {
      updateView()
    }
  }
  
  static let identifier = "WeatherDayInfoCell"
  
  private let dayLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let temperatureLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private lazy var weatherImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    contentView.addSubview(dayLabel)
    contentView.addSubview(temperatureLabel)
    contentView.addSubview(weatherImageView)
    
    NSLayoutConstraint.activate([
      dayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
      dayLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      temperatureLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      weatherImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
      weatherImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      weatherImageView.widthAnchor.constraint(equalToConstant: 40),
      weatherImageView.heightAnchor.constraint(equalToConstant: 40)
    ])
  }
  
  private func updateView() {
    guard let viewModel = viewModel as? WeatherDayInfoCellViewModel else { return }
    
    weatherImageView.sd_setImage(with: viewModel.imageUrl)
    dayLabel.text = viewModel.day
    temperatureLabel.text = viewModel.temperature
  }
}
