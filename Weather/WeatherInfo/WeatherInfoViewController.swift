//
//  WeatherInfoViewController.swift
//  Weather
//
//  Created by Ilyas on 13.05.2025.
//

import UIKit
import SDWebImage

protocol WeatherInfoViewInputProtocol: AnyObject {
  func getWeatherInfo(
    forCurrentView currentWeatherInfoViewModel: CurrentWeatherInfoViewViewModel,
    andCollectionViewRows collectionViewRows: [WeatherInfoCellViewModel]
  )
}

protocol WeatherInfoViewOutputProtocol {
  func viewDidLoad()
}

class WeatherInfoViewController: UIViewController {
  
  var presenter: WeatherInfoViewOutputProtocol!
  
  private let configuarator: WeatherInfoConfiguratorInputProtocol = WeatherInfoConfigurator()
  
  private lazy var collectionView: UICollectionView = {
    let flowLayout = UICollectionViewFlowLayout()
    flowLayout.scrollDirection = .horizontal
    flowLayout.minimumLineSpacing = 0
    flowLayout.minimumInteritemSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    collectionView.register(WeatherInfoCell.self, forCellWithReuseIdentifier: WeatherInfoCell.identifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.backgroundColor = .clear
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  private lazy var currentWeatherInfoView: CurrentWeatherInfoView = {
    let currentWeatherInfoView = CurrentWeatherInfoView()
    currentWeatherInfoView.translatesAutoresizingMaskIntoConstraints = false
    return currentWeatherInfoView
  }()
  
  private var rows: [WeatherInfoCellViewModel] = []

  override func viewDidLoad() {
    super.viewDidLoad()
    configuarator.confugure(withView: self)
    setupUI()
    presenter.viewDidLoad()
  }

  private func setupUI() {
    view.backgroundColor = .white
    
    setupRefreshButton()
    setupCurrentWeatherInfoView()
    setupCollectionView()
  }
  
  private func setupRefreshButton() {
    let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButtonTapped))
    navigationItem.rightBarButtonItem = refreshButton
  }
  
  private func setupCurrentWeatherInfoView() {
    view.addSubview(currentWeatherInfoView)
    NSLayoutConstraint.activate([
      currentWeatherInfoView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      currentWeatherInfoView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      currentWeatherInfoView.heightAnchor.constraint(equalToConstant: 130)
    ])
  }
  
  private func setupCollectionView() {
    view.addSubview(collectionView)
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: currentWeatherInfoView.bottomAnchor, constant: 40),
      collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      collectionView.heightAnchor.constraint(equalToConstant: 110)
    ])
  }
  
  @objc private func refreshButtonTapped() {
    
  }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension WeatherInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return rows.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cellViewModel = rows[indexPath.row]
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellViewModel.cellIdentifier, for: indexPath)
    guard let cell = cell as? WeatherInfoCell else { return UICollectionViewCell() }
    
    cell.viewModel = cellViewModel
    
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let cellViewModel = rows[indexPath.row]
    return CGSize(width: cellViewModel.cellHeight, height: cellViewModel.cellHeight)
  }
}

// MARK: - WeatherInfoViewInputProtocol
extension WeatherInfoViewController: WeatherInfoViewInputProtocol {
  func getWeatherInfo(
    forCurrentView currentWeatherInfoViewModel: CurrentWeatherInfoViewViewModel,
    andCollectionViewRows collectionViewRows: [WeatherInfoCellViewModel]
  ) {
    
    currentWeatherInfoView.viewModel = currentWeatherInfoViewModel
    
    self.rows = collectionViewRows
    collectionView.reloadData()
  }
}

