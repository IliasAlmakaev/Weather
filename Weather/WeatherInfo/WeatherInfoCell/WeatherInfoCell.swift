//
//  WeatherInfoCell.swift
//  Weather
//
//  Created by Ilyas on 14.05.2025.
//

import UIKit
import SDWebImage

protocol WeatherInfoCellModelRepresentable {
  var viewModel: WeatherInfoCellViewModelProtocol { get }
}

class WeatherInfoCell: UICollectionViewCell {
  
  var viewModel: WeatherInfoCellViewModelProtocol? {
    didSet {
      updateView()
    }
  }
  
  static let identifier = "WeatherInfoCell"
  
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
  
  func updateView() {
  //  guard let viewModel = viewModel as? WeatherInfoCellViewModel else { return }
    
    let url = URL(string: "")
  //  imageView.sd_setImage(with: url)
    imageView.image = UIImage(systemName: "sun.max")
    hourLabel.text = "Сейчас"
    // TODO: - Добавить градусы
    temperatureLabel.text = "10"
  }
  
  private func setupView() {
    contentView.addSubview(hourLabel)
    contentView.addSubview(temperatureLabel)
    contentView.addSubview(imageView)
    
    NSLayoutConstraint.activate([
      hourLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      hourLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      imageView.topAnchor.constraint(equalTo: hourLabel.bottomAnchor, constant: 10),
      imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 20),
      imageView.heightAnchor.constraint(equalToConstant: 20),
      temperatureLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
      temperatureLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
    ])
  }
}
